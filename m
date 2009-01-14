From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: git-patches list?
Date: Wed, 14 Jan 2009 10:44:53 +0200
Message-ID: <94a0d4530901140044t52af8536o805786718840f1d2@mail.gmail.com>
References: <90bb445a0901121543q29d30d49yaa723b4b913a4b31@mail.gmail.com>
	 <7vr638f5ch.fsf@gitster.siamese.dyndns.org>
	 <90bb445a0901130755t6ea98bcco6b6663d806dcc2e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Akira Kitada" <akitada@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 09:46:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN1OM-0001Rd-49
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 09:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbZANIpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 03:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754824AbZANIpB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 03:45:01 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:14505 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbZANIpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 03:45:00 -0500
Received: by fg-out-1718.google.com with SMTP id 19so225944fgg.17
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 00:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VLG16oLn1qDyAo6HYz8WbT6KYW4BRCzl/oTwqqZyTHc=;
        b=HgwiL1UOlUWA6cEzfaYB5TDlIH7l4rBafGcjCzZAGp5FLhTvJJnkVS5k/hc/OMN854
         rn2hYnCE2/0zS/XRPXOj6DhfEZvChf/m1rdXApP5cwnQ5GbF9kWQJNjE/voyElqDum2G
         lYPCKtu/T5EtOnaJ61ASdY7Wnbesn3HR9/BYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=S5OP17ymSMoGmDm3p7s4oYaxgL6OpYp67/B/BKgo2kz6KoOFe4ktkyNdgRMF9KH9n6
         FZGnWuJ0zm9MmN1qtwodDFWbW4pXs7YzT1tX73pbFwDFyLb9BAXFtjigNLeOO6QztOpb
         2ML2v3kVXr8kpAcEGQQmoXM5jDkY4TeM6uqUQ=
Received: by 10.86.95.8 with SMTP id s8mr321960fgb.79.1231922698663;
        Wed, 14 Jan 2009 00:44:58 -0800 (PST)
Received: by 10.86.51.18 with HTTP; Wed, 14 Jan 2009 00:44:53 -0800 (PST)
In-Reply-To: <90bb445a0901130755t6ea98bcco6b6663d806dcc2e6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105606>

On Tue, Jan 13, 2009 at 5:55 PM, Akira Kitada <akitada@gmail.com> wrote:
> This list seems to be used as a bug tracker, discussing git development,
> user questions, announcement etc.
> I thought this is so unusual list that something should be wrong here,
> but it turned out that it looks working right in mysteryous way.
> I take that back now.
> Hmm, interesting...

Yes, it's definitely not the norm on other projects, but perhaps it should be.

That's how the linux kernel mailing list works. There are other
mailing lists for the different sub-systems, but there's no separation
between bugs, discussion and patches, which makes sense, because quite
often bugs and patches trigger discussions, and bug discussions
trigger patches.

Following this approach perhaps it would make sense to create a
separate mailing list for jgit and similar stuff.

-- 
Felipe Contreras
