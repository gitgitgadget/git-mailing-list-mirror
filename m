From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 3/5] Show full command in subprocess profiling
Date: Fri, 18 Jul 2008 22:47:46 +0100
Message-ID: <b0943d9e0807181447v44103e05i1cc0243cb6458bef@mail.gmail.com>
References: <20080717204133.23407.34264.stgit@yoghurt>
	 <20080717204238.23407.47439.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 23:48:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJxon-0003Yf-Su
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 23:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbYGRVrs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 17:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754290AbYGRVrs
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 17:47:48 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:16308 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbYGRVrs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2008 17:47:48 -0400
Received: by py-out-1112.google.com with SMTP id p76so418453pyb.10
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=M64uskG+iuv0dsAQbmsxEQWL7fhYdreAo3WdjWmoKog=;
        b=aASHnxeCVJlh1eHCMxB6vUfJgxPsZNojU3S4ujLCUXnnALe+6Eyk4DEbzhvNpzZ6T3
         2xcocuGleBDdgmJ7emGJE7pA/ArL0McDYvnhVU1r6Z1xsKGfRrewPESYS0RAHKbXTLCb
         t+aKeK9r84DRIy4Gm4u/2J9iGmonDlB5xON4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OVJxpi7LanlHnr8L4WK2OhVkEMs5uoLCzr/7nn+POFCr1LdF2pi9KpgKhOv6KNjMR3
         EERsNr/HnJZncXdj8qwJhhhMA+YyC02UFe3ls76maYs7Am5HQWIMFJ6eeShb+lqmUOh3
         YJWbK3pzPBxGazjws0y5urlQ2NDJUN/xtuTSg=
Received: by 10.115.106.7 with SMTP id i7mr510538wam.131.1216417666754;
        Fri, 18 Jul 2008 14:47:46 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Fri, 18 Jul 2008 14:47:46 -0700 (PDT)
In-Reply-To: <20080717204238.23407.47439.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89082>

2008/7/17 Karl Hasselstr=F6m <kha@treskal.com>:
> Showing just the executable name isn't so useful now that it's always
> "git".

Yes, indeed.

--=20
Catalin
