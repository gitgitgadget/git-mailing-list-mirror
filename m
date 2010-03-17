From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Wed, 17 Mar 2010 18:00:31 +0100
Message-ID: <4BA10AAF.9050907@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> 	<4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> 	<4B8B9BF1.10408@web.de> <4b8bf32f.0706c00a.26cb.691d@mx.google.com> 	<4BA104C7.5020207@web.de> <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 18:02:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrwd7-0000vf-8x
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 18:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab0CQRB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 13:01:56 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35275 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab0CQRBz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 13:01:55 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 0A03A14E3D803;
	Wed, 17 Mar 2010 18:00:33 +0100 (CET)
Received: from [78.48.200.74] (helo=[192.168.1.202])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1Nrwbg-00032L-00; Wed, 17 Mar 2010 18:00:32 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.8) Gecko/20100228 SUSE/3.0.3-1.1.1 Thunderbird/3.0.3
In-Reply-To: <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX18R8YqwIOocP8c3WNURrZZKxulAzkuALlE/JFUx
	w/7XAfwPsPDxaHpGApPdJuly3ZrByZyupgZ3saDHs+49w5av54
	elN2r3/DWWCT0dP4ViyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142416>

> This is done by updating HEAD to point at the given branch,

Is it supposed that Git users should know from other information sources 
already what the key word "HEAD" means?

Regards,
Markus
