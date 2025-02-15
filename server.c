/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: edegarci <edegarci@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/15 00:18:57 by edegarci          #+#    #+#             */
/*   Updated: 2025/02/15 14:51:37 by edegarci         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#define _POSIX_C_SOURCE 200809L
#include "minitalk.h"

void	handle_signal(int sig, siginfo_t *info, void *context)
{
	static unsigned char	character = 0;
	static int				bits = 0;

	(void)info;
	(void)context;
	character <<= 1;
	if (sig == SIGUSR1)
		character |= 1;
	bits++;
	if (bits == 8)
	{
		if (character == 0)
			write(1, "\n", 1);
		else
			write(1, &character, 1);
		character = 0;
		bits = 0;
	}
}

int	main(void)
{
	struct sigaction	sa;
	pid_t				pid;

	write(1, "Server PID: ", 12);
	pid = getpid();
	ft_putnbr(pid);
	write(1, "\n", 1);
	sa.sa_sigaction = handle_signal;
	sa.sa_flags = SA_SIGINFO;
	sigemptyset(&sa.sa_mask);
	if (sigaction(SIGUSR1, &sa, NULL) == -1)
	{
		write(1, "Error: sigaction failed\n", 24);
		exit(EXIT_FAILURE);
	}
	if (sigaction(SIGUSR2, &sa, NULL) == -1)
	{
		write(1, "Error: sigaction failed\n", 24);
		exit(EXIT_FAILURE);
	}
	while (1)
		pause();
	return (0);
}
