From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sun, 28 Mar 2010 23:08:09 +0530
Message-ID: <2e24e5b91003281038u486cd966w1d9263b897e7c9b9@mail.gmail.com>
References: <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>
	 <20100327013443.GE10910@spearce.org>
	 <alpine.LFD.2.00.1003262142121.694@xanadu.home>
	 <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com>
	 <alpine.LFD.2.00.1003270959110.694@xanadu.home>
	 <20100327191405.GF10910@spearce.org> <4BAE5CB9.6020905@gmail.com>
	 <20100327193222.GI10910@spearce.org> <4BAE5EEC.5090804@gmail.com>
	 <4BAE601D.6010205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Scott Chacon <schacon@gmail.com>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Sun Mar 28 19:38:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvwRE-0004fO-Ox
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 19:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab0C1RiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 13:38:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61922 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0C1RiK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 13:38:10 -0400
Received: by vws8 with SMTP id 8so2177649vws.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=nJzYnEFyPlfCZHC//Fol+5IcyFLUPXsgshiZYreo0VI=;
        b=mHllbI8ChuyTKglaJEcOMFGeWnDfcJSX859S2X5tkzMHQ8pCadMA3+wEPjv93Yj2BM
         L1+TN4nNh94qg9Vmz+zwcCKfFqmHxyjvJ8zHEXW+IYeCPS5bA9SZtu4EJHEwHQXyUPJ1
         pKS+7/Hrv+iAIb64dQxVogWDYuTqXCGhkOLjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AKfwAqPEzcnyknyW0Ri3F2mnv4L7oniG5lOolQVrjPZnVxzluVWxTYF0cruVK+SEDw
         tINAZS622yz2KaO/ozTUhAhwlKdGK6O+VVbCyOqjnsaqM5mKGxA/jlTgg83MJQNefY3U
         PzuPZCOoLpJ2nDQDjXAFbZIcMEbu5PUAdFIao=
Received: by 10.220.100.212 with HTTP; Sun, 28 Mar 2010 10:38:09 -0700 (PDT)
In-Reply-To: <4BAE601D.6010205@gmail.com>
Received: by 10.220.121.233 with SMTP id i41mr2399310vcr.163.1269797889594; 
	Sun, 28 Mar 2010 10:38:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143406>

On Sun, Mar 28, 2010 at 1:14 AM, A Large Angry SCM <gitzilla@gmail.com> wrote:

> My combined repository also includes Scott's progit book and examples
> repositories. I'm guessing that git-fsck did not limit itself to just the
> object reachable from the torvalds/linux-2.6/master ref.

<struck speechless>

You have *one* repo containing both Scott's book and the Linux kernel
tree?  "large angry SCM" is probably an understatement then... any SCM
has the right to be angry mixing up things that are so unrelated!

Or did I totally, *totally* misunderstand...?
