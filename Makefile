# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: edegarci <edegarci@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/15 01:52:00 by edegarci          #+#    #+#              #
#    Updated: 2025/02/15 14:21:53 by edegarci         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
RESET = \033[0m

CC = cc
CFLAGS = -Wall -Wextra -Werror
RM = rm -rf

SRCS_SERVER = server.c utils.c
SRCS_CLIENT = client.c utils.c
OBJS_SERVER = $(SRCS_SERVER:.c=.o)
OBJS_CLIENT = $(SRCS_CLIENT:.c=.o)

NAME_SERVER = server
NAME_CLIENT = client

all: $(NAME_SERVER) $(NAME_CLIENT)

$(NAME_SERVER): $(OBJS_SERVER)
	@echo "$(YELLOW)Compiling $@...$(RESET)"
	$(CC) $(CFLAGS) -o $@ $^
	@echo "$(GREEN)$@ compiled successfully!$(RESET)"

$(NAME_CLIENT): $(OBJS_CLIENT)
	@echo "$(YELLOW)Compiling $@...$(RESET)"
	$(CC) $(CFLAGS) -o $@ $^
	@echo "$(GREEN)$@ compiled successfully!$(RESET)"

%.o: %.c
	@echo "$(YELLOW)Compiling $<...$(RESET)"
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	@echo "$(YELLOW)Cleaning up object files...$(RESET)"
	$(RM) $(OBJS_SERVER) $(OBJS_CLIENT)

fclean: clean
	@echo "$(YELLOW)Cleaning up binaries...$(RESET)"
	$(RM) $(NAME_SERVER) $(NAME_CLIENT)

re: fclean all

.PHONY: all clean fclean re