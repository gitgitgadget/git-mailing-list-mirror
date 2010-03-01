From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Better cooperation between checkouts and stashing
Date: Mon, 01 Mar 2010 19:29:25 +0100
Message-ID: <4B8C0785.30505@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de> <7v1vg4ufas.fsf@alter.siamese.dyndns.org> <4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 19:33:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmAQt-0001Bk-KF
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 19:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab0CASc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 13:32:56 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:39594 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab0CAScy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 13:32:54 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 9837C150E565B;
	Mon,  1 Mar 2010 19:32:19 +0100 (CET)
Received: from [78.48.194.16] (helo=[192.168.1.202])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NmAMx-0005cT-00; Mon, 01 Mar 2010 19:29:27 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com>
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141341>

> Markus Elfring's goal (I think) is to associate local modifications with
> a particular branch, *not* carry them across branches; that is, the goal
> is to stash local modifications away when we leave a branch and only pop
> them off the stash when we RETURN to that same branch.

You are right. - I am especially interested in this use case.

I would like to stress the relationships of files for a specific software
development task

Regards,
Markus
