From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: What's cooking in git.git (Aug 2009, #06; Sun, 30)
Date: Wed, 2 Sep 2009 14:16:01 -0400
Message-ID: <eaa105840909021116q7cdbab85tdca0cd1f47360ad7@mail.gmail.com>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
	 <m37hwili5q.fsf@localhost.localdomain>
	 <7vtyzmliai.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 20:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiuNT-0004vt-3A
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 20:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbZIBSQC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2009 14:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbZIBSQB
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 14:16:01 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:55222 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZIBSQA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2009 14:16:00 -0400
Received: by ewy2 with SMTP id 2so1098767ewy.17
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=sLkmhBlzwDLu7/2FHgHuvWmOg2R5uj/AZOYJAvcViVM=;
        b=SP44nnDDGzUVcebKOPHlruERa9feA70PFm5d8V/Q1jdI6mcifcxLmx1QBbZbz1+y8b
         sZ1oY6NquiMZlegZE2+Iqe6YQG7RZgNDDBQW4QitGuyaMnPiYh4p5py7FolkygPiFm5X
         39SVrHOYtxGatz+T9WPwJcdo9vuYqCA9p1xVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Gkz8EH4dyhczNerC3JIzJAqdL7hGSHBY/eOMXsFAOB7+Ad2WUvxUA4c/LyPqTVyc2G
         MvPN7ig5sl3DDP/XAOe5m/Jf5bLg/EpkhXyKE1NbB4dPqzj/8reTj1JltXkmu1P+0iAD
         UrwS3veraap2J/lKL1/m1AKfuXAXJ/zxn5tYs=
Received: by 10.210.135.20 with SMTP id i20mr8290584ebd.18.1251915361391; Wed, 
	02 Sep 2009 11:16:01 -0700 (PDT)
In-Reply-To: <7vtyzmliai.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 1376e6ed5ac338a5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127625>

On Tue, Sep 1, 2009 at 12:51 PM, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> There is replacement series sent to git mailing list a little while
>> ago.
>
> Thanks; I've replaced and pushed them out on 'pu' for now. =A0Will ho=
pefully
> start merging earlier parts to 'next', but how widely is Hires availa=
ble?

It was added to the Perl core in 5.8. Gitweb already depends on 5.8,
according to http://article.gmane.org/gmane.comp.version-control.git/83=
339

Peter Harris
