From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: commit a63d7ed3017e312ddc752ac89a7d292a745d5f11 broken on MacOS
Date: Thu, 07 Jun 2012 18:14:45 +0200
Message-ID: <4FD0D375.9060902@web.de>
References: <4FD0964E.7040302@web.de> <20120607162032.Horde.3lGNYXwdC4BP0LiwzlCRupA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Thu Jun 07 18:14:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScfMK-00044q-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 18:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab2FGQOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 12:14:48 -0400
Received: from mout.web.de ([212.227.17.12]:54017 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab2FGQOr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 12:14:47 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MTPit-1SVl2n0dux-00SIXO; Thu, 07 Jun 2012 18:14:46 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <20120607162032.Horde.3lGNYXwdC4BP0LiwzlCRupA@webmail.minatec.grenoble-inp.fr>
X-Provags-ID: V02:K0:VItvm6jnx0QuMw97XtssZY2VYWjsQiIq3fGlV+4Ixqu
 P8DRmdV33Q9N0U2KF/nqicJEXth5kKkaCN259HUgINsdgkDcnW
 1qVRtofKp3Ok6BEJtDZb5yN8Ey09hhTt/ZJ8l1gu3smukKxPTD
 TRKdGokrDwXpNSicFlZ4fAEv0wiYpMt4T28ZnG7GFCWVrft2Rt
 U0WoqmrQNnHAXYVgxmVwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199412>

On 07.06.12 16:20, konglu@minatec.inpg.fr wrote:
> Does it work if the whitespaces are deleted so that it becomes
> /^pick .*/i\exec gi..." ? (see the patch corrected below).


I didn't manage to appy the patch, either 
fatal: corrupt patch at line 14
or, if I remove that line
line 14 is bad, or there is no email address.

Does the patch apply on your system ?
/Torsten
