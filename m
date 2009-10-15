From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodule-summary
Date: Thu, 15 Oct 2009 12:34:20 +0200
Message-ID: <4AD6FAAC.70500@web.de>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org> <4AD61880.4040600@web.de> <7vfx9lbtpf.fsf_-_@alter.siamese.dyndns.org> <4AD6423D.10307@web.de> <7vskdla98f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 12:46:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyNqt-0008VX-2l
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 12:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762077AbZJOKmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 06:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757063AbZJOKmF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 06:42:05 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33706 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757187AbZJOKmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 06:42:04 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 2AEAF12C7AB05;
	Thu, 15 Oct 2009 12:34:24 +0200 (CEST)
Received: from [80.128.80.231] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1MyNf5-0005MB-00; Thu, 15 Oct 2009 12:34:24 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <7vskdla98f.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18CMXiAUJ+KqFPpxyps5HbzmfgEecV459nZ4+2/
	YTpkEbXo8o05q61pRKgSTQkFX96zuS4WWoofBwJlViVLCwhzs+
	razLET30iyy/3egQTQDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130386>

Junio C Hamano schrieb:
> I am _not_ married to the naming "shortlog", by the way, and shortlog is
> rather a bad name for it.  Sorry for suggesting it; it is quite different
> from the actual "git shortlog" command output (and no I am not suggesting
> to make the output similar to shortlog), but rather is more similar to
> "log --left-right --oneline".  But I think you got the point.

I have no strong feelings about the option names either. What about
"--submodule=short" for the current default git diff output and
"--submodule=left-right-log" for the one resembling the current output
of submodule summary? I really don't know, if there are better proposals
i'll happily use them.
