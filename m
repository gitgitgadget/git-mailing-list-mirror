From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 2/6 (v4)] basic revision cache system, no integration or 
	features
Date: Mon, 5 Oct 2009 13:51:50 +0100
Message-ID: <c77435a80910050551g6eaee163r6c08e007b8fe71f2@mail.gmail.com>
References: <op.uys3qlsjtdk399@sirnot.private>
	 <op.uyuwkovjtdk399@sirnot.private> <op.u061bavktdk399@sirnot.ed.ac.uk>
	 <7vbpkmk2mm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 14:53:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mun3k-0008Qr-QE
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 14:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609AbZJEMw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 08:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754492AbZJEMw2
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 08:52:28 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:36853 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbZJEMw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 08:52:27 -0400
Received: by bwz6 with SMTP id 6so2443229bwz.37
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=iczj0WcfAGGEX2VeHXm6SnhHH6ejBpwUdZwx1/S3Ffo=;
        b=ZcE78S/igR16d8cyd3+gxEHWeBME6CcyR8eY9QbJq8RSDvsuOlv9GvN7qaH6bB5FN5
         CLMXXGG3cD7ZHpitmqmHdS3Z/Z4u1bFt9LMalhagJt6xjhTT47Dmflnrq6hEGMKy363F
         +lxPYV0MVMO3p0ouAGFkWM6wAdJ2fcTEFsKIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uczsfcV8lYdDvHN88n8xtC7lrxyFbCLNwyMh4UUGmC1Lm5VOslq3jyNW95t3CXSfZq
         WQ//R2op31OR7dC9/16peS3I6AyLZf5ypF5u47wB5SD8XtuEFlsPUHB9PqNkhgQqDrUq
         vyCTDtxGrT8/aq2Ce35njtVNsSZ45Qu+2t6Fw=
Received: by 10.204.162.137 with SMTP id v9mr3929546bkx.60.1254747110398; Mon, 
	05 Oct 2009 05:51:50 -0700 (PDT)
In-Reply-To: <7vbpkmk2mm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129560>

> The entire series is unusable due to whitespace breakage.

Shit sorry about that.  I think my mail client reset some settings
when I upgraded.  Will resend.

I feel like such a klutz...
