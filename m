From: Chris Velevitch <chris.velevitch@gmail.com>
Subject: Re: Eclipse Plugin install issue
Date: Mon, 9 Feb 2009 21:55:24 +1100
Message-ID: <b0a3bf780902090255o6a52555eq18235320782652eb@mail.gmail.com>
References: <b0a3bf780902060717l653cc6dcx385aa147f606a520@mail.gmail.com>
	 <200902061710.34337.robin.rosenberg@dewire.com>
	 <1234007463339-2288907.post@n2.nabble.com>
	 <200902080120.06894.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 11:56:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWTor-0001z0-Hx
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 11:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbZBIKz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2009 05:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754343AbZBIKz1
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 05:55:27 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:21019 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbZBIKz0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2009 05:55:26 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1748800rvb.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 02:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=sWAZ1zGfpEF7qLielNQ5Ye1Q9DFXgiTAPV0Kf7UCAmU=;
        b=j6+qVKsh07uxVTyAQg++6rGimzPaCd3F10Ke3Xepk6St2iCQ5DnnkTVHREiuLv5kgu
         MdFJj3TGpvmZeP9ns5Bb4DLtR0Rmwim3eQ3aKZwiheODCudtOzWRHFMp/rwhodp7dWc6
         vDztQDa1a2RtWMzjvYwuO+ehZJ5fjdnhNZmxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=RNnlpJFr6FedTPfAplF81oOctATm4EOibNJ4v3ytZJ41FJgSSsECt54BwDRgLz8Vhe
         8dnEoBrmg5GHhNjNlXZ4vHfUF01FhwQdlWlYE9z2YLKaroZRvRZLFXCj3FKtFSeFVmVc
         eEQ2mm6arl+SkGIA9EcfFZaSeGxKr66+ycFCs=
Received: by 10.141.68.12 with SMTP id v12mr155692rvk.51.1234176925022; Mon, 
	09 Feb 2009 02:55:25 -0800 (PST)
In-Reply-To: <200902080120.06894.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109062>

On Sun, Feb 8, 2009 at 11:20, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> l=F6rdag 07 februari 2009 12:51:03 skrev Tim Schofield:
>> I am getting this identical error. I am using 200902052244 and eclip=
se
>> Version: 3.4.1 Build id: M20080911-1700.
>
> Was that a pristine version of that build or did you have other plugi=
ns too?
> I know Eclipse can give very confusing error messages sometimes when
> things don't match up. It might be that we have a dependency requirem=
ent
> that is too strict and collides with another plugin.

I installed Eclipse-jee-ganymede-3.4.1.tar.gz and Web Tools (WTP). I
also have EMF and Mylyn, but I can't recall if they came with it or I
installed them.


Chris
--
Chris Velevitch
Manager - Adobe Platform Users Group, Sydney
m: 0415 469 095
www.apugs.org.au

Adobe Platform Users Group, Sydney
=46eb '09 meeting: Cairngorm Basics
Date: Mon 23rd Feb January 6pm for 6:30 start
Details and RSVP on http://groups.adobe.com/posts/d094878396
