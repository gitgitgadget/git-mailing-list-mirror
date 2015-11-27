From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] convert.c: mark a file-local function static
Date: Fri, 27 Nov 2015 09:09:52 +0100
Message-ID: <56580FD0.10109@web.de>
References: <56562D09.70205@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7Zn?= =?UTF-8?B?ZXJzaGF1c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 09:10:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2E6j-0005b3-Ii
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 09:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbbK0IKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 03:10:17 -0500
Received: from mout.web.de ([212.227.17.11]:53909 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbbK0IKP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 03:10:15 -0500
Received: from [192.168.2.145] ([195.176.0.34]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LyljP-1aQOpP1qHH-0169mj; Fri, 27 Nov 2015 09:09:56
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <56562D09.70205@ramsayjones.plus.com>
X-Provags-ID: V03:K0:srrBOsPha5c28M3t2Czdh6YWbrj9f+iar6867zOjdAZOmvQOwG5
 3CAJWpeRWXhCZcD7Er2eHtTC6RN4j6z1hdz7YQDX22uDaX+KnYnBFoVNKnBSLPGVzfZzSKI
 Z7uEQNyK9k1KyeiOrlXx5r8NhpjGNcV3wfdzZkztwnUf9m4MmBrFuOF8nGZNjOKoMYo6NK0
 agh5KI6g7wiw+cfrZZp5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i+FiYWrn7PQ=:pt/PfV6K1jh2WVHbcj/AAi
 wNc+spDpR33q7vlMGNwBB/07bqyEiWbPVT6liH4RbCPzNXqWA8X8BYqioO5yCIVLspX4QY9G5
 iusJhkvIju/b9WPArVdPfh6XFwTOzG8uD5eTj+Ka5lMOoHZb2z0qt0u5KTCTzuly0F405/fzU
 ZRBHgAOZSpUgEgh0TBcKZ6oIrV6SvmabsLZRhiMVpZUUlBNfgb1LF4U3Qc5WH7WDTcaqQXJgj
 WXZ+zeSwmbNL+gS0c3O40gsnnhalopMYVTg+rXwEsOR7qFvX7g+4dMNM+f6efSb5OXUYTEFud
 KmykVW23G+JYQ1nQQGcC/7A0xsdh4g1RKLYS0q8bdfs4ZiAcdPT/bV75MskVlAKg6z/gKfTmO
 7mVMccUX1p8Ogi9sFsnqfOCEpe57MjvnJ7G9oSe1Vcuy5IUZxRcOYb0HW3j3hN8xG0m7nM5cY
 hkrpGCMa0kt0/vrNJ8IniaYagOCOxIUIMAZFevvpG9rsAus77/QHezeGXX40X5Ms0JPRLy7SH
 KZGH3akKnFhgmQyimq51dO7TNN6I9xutB3+HkKWkpjqO8eBxztNJHQLNopxGoQj4QpxEngmtH
 S4hLU7SWG+3v8GiNTI0y8XiBgUArgoq99M14aDqwtlUsh4I2TDrn9/5CdNcVexbnzaE1l4l8x
 6d1vyVaI5s+OfAAXfNsdR1SK3nxr7ID0KQ2DxaLNZYkWtIIoSSRLADdk+Js7AyqRQIAnCTShj
 HbxLY/6aGZv3652quUmaXw8NvWhjm0Z6VWwt+ADYESu0c+/aDj9nVI1hwnZ+NyA7fpwI8Ban 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281767>

Thanks for catching, I will.
