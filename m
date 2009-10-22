From: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Thu, 22 Oct 2009 08:41:53 +0200
Message-ID: <ee9cc730910212341w5698e18fqc12a6634a52a93be@mail.gmail.com>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
	 <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
	 <7vbpk7w9qx.fsf@alter.siamese.dyndns.org>
	 <ee9cc730910161100r71818303v343f555151db4dcc@mail.gmail.com>
	 <7v7huvuptn.fsf@alter.siamese.dyndns.org>
	 <7vpr8nt894.fsf@alter.siamese.dyndns.org>
	 <ee9cc730910161419x608f5972x705ce8088d72c94a@mail.gmail.com>
	 <7v3a5irkel.fsf@alter.siamese.dyndns.org>
	 <ee9cc730910162350p250b8afak767b0626bede34e4@mail.gmail.com>
	 <ee9cc730910170942p7869d62ra08571948675d696@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 08:42:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0rN3-0002j7-IY
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 08:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbZJVGlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 02:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbZJVGlv
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 02:41:51 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:48132 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbZJVGlu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 02:41:50 -0400
Received: by fxm18 with SMTP id 18so8755463fxm.37
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 23:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=KnBxjDEviNBAgwet0YdSkLv0gA6XNowm3jQSJuzV0QM=;
        b=HeqNPEQY37tnz/YjR45wtn2Nix6KoedhqT2YKV0BFN38ojZKOrVGzCoGQNwQA+K6jY
         dBrur3Kri9Tq2ZFUKSoLr6MYiHHCCNX/PnPnsmI1O4RW9ZCM1fNEaPBhovgNGsV5LhLc
         HZZHJg98luPMKoOsSr6AYh53zAl/oxq5JMc/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Q0OBpAclmHWUHOSs8QhsRBRQ/BE4KK3DM/5mfTGr4U+1iftZnUD1XVU7Cv0p5bl3UV
         YVgzcpotzYLwg19Kko7ogGLS0b/xKw3jS6QAdsyHsTp+FU5U0//hZPkCbLgOOGoibhLL
         cMJubzk3GxBGqsQCG4STMXR8jdIR+/wYUOKGo=
Received: by 10.204.48.140 with SMTP id r12mr15221bkf.112.1256193713923; Wed, 
	21 Oct 2009 23:41:53 -0700 (PDT)
In-Reply-To: <ee9cc730910170942p7869d62ra08571948675d696@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130997>

Hi all,
I have creates a group here mediawiki-vcs and you are invited to join,
it will be to create a git/vcs backend for the mediawiki.

http://groups.google.com/group/mediawiki-vcs/browse_thread/thread/ad3e0a194c8ac1d5#


Also, I have started to document the git internal structure, with the
idea of a gitbus, a dbus like system for doing rpc calls over git for
expensive and repeatable operations.
http://github.com/h4ck3rm1k3/GitBus

thanks,
mike
