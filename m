From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: APIs for automatic patch generation
Date: Tue, 23 Feb 2010 18:23:01 +0100
Message-ID: <4B840EF5.2090306@web.de>
References: <4B803AB8.30304@web.de> <4B840AA2.3010604@web.de> <fabb9a1e1002230907u6471efa5w234a5dabfa4ba5e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 18:23:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjyTx-0000pE-B3
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 18:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab0BWRXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 12:23:24 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:59850 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab0BWRXY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 12:23:24 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7731B148BC5D4;
	Tue, 23 Feb 2010 18:23:01 +0100 (CET)
Received: from [78.49.33.20] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NjyTN-0006Ae-00; Tue, 23 Feb 2010 18:23:01 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <fabb9a1e1002230907u6471efa5w234a5dabfa4ba5e1@mail.gmail.com>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX19sagZm4Rpe56ILG5v/0KhBL+auuZ3WvSb8Fspq
	DzNejPqitmhz12YIN9bj/ZRbx3C2oWkzzp3pJ4Q/VcbkbS3Xbw
	b36QhwcUy6tLo4McyswQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140817>

> Until libgit2 is done, just shell out and call 'git format-patch'.

Thanks for the link.

I do not need the whole functionality of these commands for my library. I am
looking if the mentioned data items can also be really retrieved by command line
parameters.

Regards,
Markus
