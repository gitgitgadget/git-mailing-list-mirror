From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/4] make t6302 usable even without GPG installed
Date: Tue, 15 Mar 2016 20:38:41 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603152038110.4690@virtualbox>
References: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:39:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afuo3-0004kW-0v
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965819AbcCOTi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 15:38:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:56145 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbcCOTi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:38:57 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MWkep-1aIT313Gt1-00Xw1z; Tue, 15 Mar 2016 20:38:45
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:0anWWGzqye4xcOL7L9tny8Pg61V5UI5xRvEMMwkQNMd+vWUbmSe
 Y1bmA/KRQ67bTZTSYYBl3yJcc6I4ltEAtXf6HOwTQIcCN9l4bMVhGOflk5itm8XYKfpmnTF
 sumCGGF24z6uHY6WrpiOYl7SXwxrwRLa50tcxtHZ2qnHzzt50Bh+wkwsK7jfVSBkz2QqS5I
 KEB5+haeugWWrqywhR5Kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:px2dpRemNNU=:le41MDtQwIuz273YujlqsF
 Meui6+ZoDDr9y4g1CJNh6Gx6pmI/17UKN8vVx8/SXrmfZwjXQfqhQ3jKaHHR96Ai1FYRpvrnD
 57knWu5JQ7TZAtATH8h4QpCGn3BpQ61ONraEYQVAcCm+PijmE8rVZGo4bSL5jg9s68XgQdZIA
 D/BfQ9Xat8lM1SpgfzQk6TcXHaGBz9KtvGOMH6db+9y8ajW79cJ1Gjsm9Zy/B7X5CIIWlZ4XL
 aPk4q1McuVe/LxrpHNBJ318bf+y7BfoyWexvmHwdj7wfpo9H6HQ1RR3qqu5IIcmRwHwsiyR9A
 3yqab7lkR1rQVn7ZGDkoVUAIz9TzoGCLSt8662uRU5TucuwLVPwc4JYlJ3KNvnJcQWm0iim8f
 QJyjYM03xqzINFKheIq06t7IvcqGy7f1b/94ixBfzfxKSQhVEDdoSwdpllMM4MxNJvXfo9dK4
 PqFBtWgnnJDo7wLrBB8pCh0t2IxPfPXz2IT/bc6c/xJPlZIR4Nu6hWzzq5E3WHenYIKIQ0oTO
 3pkr4lCjGidFIkPvwkVWaiTvjnTXQkyDT35knTIacLadgt955nNwvzXK6fqxEqSZ5YMpq66I0
 0NhTrbH1BdbtvMoHNRzKcCG6B8gT41pxycIGriF6brzGz5Z4Um0RXsuObgPtLSUCBx5miyV38
 gn3P0vxwizWTQNeRF3U9Jn04RQEN7kt1PHA9jbW54b0jb7M0xZtQVT3fU68nIZH9SCgLsYJaw
 HZl3fuWL7M7DMeJfm/PWwgXnbmu++/MXmb9+z3/rg0AL+WZfcBcYAZmlEwWMY629n25Iq2j7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288900>

Hi Eric,

On Sun, 6 Mar 2016, Eric Sunshine wrote:

> This is a re-roll of [1] which aims to allow t6302 to be run even
> without GPG installed.

What a beautiful story this patch series tells. Truly a pleasure to
review.

Thanks!
Dscho
