From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/24] t9300 (fast-import): use tabs to indent
Date: Fri, 24 Sep 2010 03:21:49 -0600
Message-ID: <AANLkTi=EBa5EORv84Yf0b4sEB-0t8eMzBXVZcd8HnWEx@mail.gmail.com>
References: <20100701031819.GA12524@burratino>
	<20100701054849.GA14972@burratino>
	<20100817170216.GA14491@kytes>
	<20100905031528.GA2344@burratino>
	<20100905032253.GB2344@burratino>
	<20100924065900.GA4666@burratino>
	<20100924071350.GH4666@burratino>
	<20100924085424.GD22658@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 11:22:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz4Ti-0000Tq-SB
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 11:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab0IXJVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 05:21:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42534 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab0IXJVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 05:21:50 -0400
Received: by iwn5 with SMTP id 5so2247786iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 02:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=G0d2ifmsHtzNbE5MFJhidsQ76ROMzxnySLRHK42ouiM=;
        b=sje1zNHWR327h5uRs0oaE/aW9XDs2RrKZjjNvUF2W1PCRWLO3C8gDpWzvuILbrRON+
         XEpMmUl9aaqX4JRXObLnObSr5tdAcyMNOfP2TJhE7qYq6K/oZ7NI3B0zJFldMMDWlyrY
         DR2gb+6gnOP2hkO5WCbS9c7YIyFvnHb1t1J/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sU/ddGCCyew8d+cVAVtW22mWOxaXE0v2aEykehYHCRamfFNKGRaOqy59YwJTmEeI2s
         /E/cVDG1AR2Z02vSZqlNlZJvkwZhbjCOjDrL1mLP/xtJ+b3YxA4h0Ix+jpNRniEWtoj6
         zhjlTwXaZbcJKx5XlmuHzyceRviWiPUH/IjJ8=
Received: by 10.231.13.139 with SMTP id c11mr3227478iba.188.1285320109675;
 Fri, 24 Sep 2010 02:21:49 -0700 (PDT)
Received: by 10.231.11.65 with HTTP; Fri, 24 Sep 2010 02:21:49 -0700 (PDT)
In-Reply-To: <20100924085424.GD22658@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156964>

Ramkumar Ramachandra wrote:

> Patches 7-24 are boring non-functional changes that involve re-styling
> and re-indenting. Maybe put them all in one large commit? It's fairly
> trivial to review these changes anyway.

Yeah, sorry for the mailbomb.  Whichever changes are wanted are meant
for squashing indeed.
