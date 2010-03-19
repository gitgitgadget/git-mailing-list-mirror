From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Fri, 19 Mar 2010 09:28:38 +0100
Message-ID: <4BA335B6.4000103@web.de>
References: <4B67227A.7030908@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> 	<4B8B9BF1.10408@web.de> <4b8bf32f.0706c00a.26cb.691d@mx.google.com> 	<4BA104C7.5020207@web.de> <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> 	<7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de> 	<32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com> 	<b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com> <32541b131003181033p7916d92frc1269b95c292e3db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 09:28:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsXZc-0007Mg-QP
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 09:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab0CSI2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 04:28:41 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:42031 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab0CSI2k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 04:28:40 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 2ED2D14ED6B70;
	Fri, 19 Mar 2010 09:28:39 +0100 (CET)
Received: from [78.49.72.233] (helo=[192.168.1.2])
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NsXZP-00074L-00; Fri, 19 Mar 2010 09:28:39 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <32541b131003181033p7916d92frc1269b95c292e3db@mail.gmail.com>
X-Enigmail-Version: 1.0
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/HM8HYRt+kVWBSvkbSrSRGn+4YUs5OSrmsL2aM
	sspUyBXkJ9A2lqZKfW8qcuxk+AKsqENEcXg+a84ryHREgdBfmp
	2xpNFVgQj63mVfHWmIwg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142567>

> The stash can contain multiple entries.  They're stored in a stack,
> but you can pull prior entries out of the stack if you want.

I am missing a semantic relationship of the stashed files to the work that they
belong to in various branches. I would appreciate to see a clear connection
between them.

Regards,
Markus
