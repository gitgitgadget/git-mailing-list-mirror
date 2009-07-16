From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [ANNOUNCE] Re: GIT 1.6.4.rc1
Date: Thu, 16 Jul 2009 08:55:35 +0200
Message-ID: <20090716065535.GG12971@vidovic>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 08:56:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRKtS-0002Up-JJ
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 08:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbZGPGzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 02:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbZGPGzw
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 02:55:52 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:50297 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbZGPGzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 02:55:50 -0400
Received: by ewy26 with SMTP id 26so4592476ewy.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 23:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=iCvUiCkGTo4zCMQqXEcbjaXRSc+NxLatCy4buzIYpNs=;
        b=VpaE6rhNks/B49bqzD6OtJD0K8tYbGjMMLItPdiQ7DMfh5Tg+npUhGOQ+bhqEwBtgl
         RDmrEx+m6FngAWtMRBRn0mar8/A9p2uxVaG5PoFrVv05Jb176sgqXK6SAgZsIhCaW3+m
         nc3Hi1T/mkMLt1tJ18qQuiJUKOa6TEWY1LrMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=J1RJE+MhpDgP8TgKI8GQF1twxllqhlbHIHnl83ld2rpKaPQRNnQ8XcTANJDnCmpUPR
         DW5pCd65riDjA+a4UczZl+FKo5TMwYw/8oCetcjtQowC9eRWyXUPVL1jcAVdh7uETGkr
         cxao7KYbLm8mM++6NMolEOQuKBm+M11+/dngI=
Received: by 10.211.195.3 with SMTP id x3mr9239449ebp.28.1247727348880;
        Wed, 15 Jul 2009 23:55:48 -0700 (PDT)
Received: from @ (88-121-124-61.rev.libertysurf.net [88.121.124.61])
        by mx.google.com with ESMTPS id 10sm3983370eyz.51.2009.07.15.23.55.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 23:55:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123370>

The 15/07/09, Junio C Hamano wrote:

> A release candidate GIT 1.6.4.rc1 is available at the usual places
> for testing:
> 
>   http://www.kernel.org/pub/software/scm/git/

Could you push into kernel.org, please?

-- 
Nicolas Sebrecht
