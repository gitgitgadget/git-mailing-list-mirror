From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Better cooperation between checkouts and stashing
Date: Tue, 02 Mar 2010 10:35:06 +0100
Message-ID: <4B8CDBCA.4030101@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> 	<4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> 	<4B8B9BF1.10408@web.de> <7v1vg4ufas.fsf@alter.siamese.dyndns.org> 	<4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com> <7vk4tvsu6x.fsf@alter.siamese.dyndns.org> 	<4B8C2F90.8080104@web.de> <b4087cc51003011741w29023914wec78f9acd6efb516@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 10:35:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmOVl-0001Gt-Hb
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 10:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab0CBJfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 04:35:13 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:59019 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab0CBJfM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 04:35:12 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id A0D901414AB81;
	Tue,  2 Mar 2010 10:35:10 +0100 (CET)
Received: from [78.54.163.252] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NmOVS-0007W6-00; Tue, 02 Mar 2010 10:35:10 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <b4087cc51003011741w29023914wec78f9acd6efb516@mail.gmail.com>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+28CNXpL3kPaA5qWqpsmmYRQ0fB1ESi93p6K4D
	bjbhh19wyUpnY23z3YAbExGR7XSjEAxFanDsei5/GxSN5DF2ux
	IhPmQmTI5W+Kc5wVf/dw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141377>

> The other use case is the one that git already assumes to be popular:
> People want local modifications to remain in place across branch checkouts.

Are there software developers (besides me) who would like to work in the
opposite way on demand?

How are the chances to make unfinished and uncommitted content updates sticky
for a particular branch (or a selection of branches) so that changes will not be
mixed more as it will be really required for an editing task?


> The "git checkout" command is designed to carry local modifications
> across branches transparently;

Which wording will be preferred to "reflect" this fact in the manual and other
documentation?

Regards,
Markus
