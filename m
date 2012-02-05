From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] t: mailmap: add simple name translation test
Date: Sun, 5 Feb 2012 00:17:38 -0600
Message-ID: <20120205061738.GB1870@burratino>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
 <1328385024-6955-4-git-send-email-felipe.contreras@gmail.com>
 <20120204201218.GF22928@burratino>
 <CAMP44s1ZPQJzHzYj7e4Kj3Cu+qq0Q3uKrwsE=xS7BmmSqd3gSw@mail.gmail.com>
 <20120204211544.GC3278@burratino>
 <CAMP44s0Z=k6VBfv0HOGHyMBLRcPauK7K5RNvuRDbfq5=5aKVpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Jim Meyering <jim@meyering.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 07:17:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtvQ4-0005PI-1i
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 07:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078Ab2BEGRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 01:17:43 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38468 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab2BEGRm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 01:17:42 -0500
Received: by iacb35 with SMTP id b35so6860916iac.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 22:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8hb6JNZ5LN914inLt/IktT0eFR49c6fwO6CKxzUjqu4=;
        b=ANPTC6/780/DAO/KmDrKT8XSBUgmuhmwhAp4abPKp+WGSgK33aAsxcszzOp5Mn/4ED
         0nGQr5cu03mTK0uREnllzjc0ptWSS3Z0n/7jkkJV+3MOThpOG4ZN1IQY9AADVOFA50MT
         Ju3XuqlBcqvm86OIcsSeBOyCuASILqcAZsnlo=
Received: by 10.42.174.71 with SMTP id u7mr12364865icz.44.1328422661864;
        Sat, 04 Feb 2012 22:17:41 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id mr24sm19908743ibb.1.2012.02.04.22.17.41
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 22:17:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0Z=k6VBfv0HOGHyMBLRcPauK7K5RNvuRDbfq5=5aKVpg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189930>

Felipe Contreras wrote:

> You mean the commit message, you haven't made any comment about the code.

No, for this patch, more important than the absence of any explanation
in the commit message (which is also important) is the code change
that seems unnecessarily invasive.

You've already demonstrated that I do not have the right communication
style to explain such things to you and work towards a fix that
addresses both our concerns.  So I give up.  I'll just give my
feedback on patches that concern code I care about and an explanation
for the sake of others on the list that are better able to interact
with you.  I am willing to work with or answer questions from anyone
including you, though.

Sorry,
Jonathan
