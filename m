From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit RFC] Pull request for build/install work
Date: Tue, 5 Aug 2008 22:10:41 +0100
Message-ID: <b0943d9e0808051410v39a95a66se053ea8c764e484e@mail.gmail.com>
References: <20080724202031.55dec8e8@whitehouse.id.au>
	 <b0943d9e0807251446w1e9ed73erfa7c1638191d88a@mail.gmail.com>
	 <20080727162750.25b7cdf3@whitehouse.id.au>
	 <b0943d9e0807270121x43b0a454g1042c0cfe650f2c1@mail.gmail.com>
	 <20080731162916.14ffc9fd@whitehouse.id.au>
	 <20080804143838.GD12232@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Daniel White" <daniel@whitehouse.id.au>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 23:17:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQTue-0001jm-IT
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 23:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbYHEVQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbYHEVQr
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 17:16:47 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:19625 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbYHEVQq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2008 17:16:46 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2788854rvb.1
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=t2IvTpiY+smurRj5rFuSyRxh6UENorYB5iQ0ZOr95t4=;
        b=nb1ix7GTZQ0lgIXvYNnXQJ1k64Pn8DvP8ljJ/23mwjj+Y7X8dXHfGqqZF4HE7mfQov
         H6krq64ajm37bafHGRiH4qGthQfONhY23VCHQcIi+kPpwyMd+LYpTNv0TYh1NrLfa5AS
         PSGlY3UQMmdhlAuSPC/E9Nb+/xqt1UHD6N+AA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tJmcJg6htriOmeWj7rRPEOjl2CMg+TwU/65OWwkuGoudoUslHnmdiAPRjCJXnbdJ8C
         VtHupOGUkBvxoEAW21vcryap2+9gNoLkbb8MgteF5ZpxbO7Y4doj9L4mHlleXdRYZY34
         2NF1vFXnWHcl8MNLmw4Nqs2QFi5O4VlUfL6Fw=
Received: by 10.114.77.1 with SMTP id z1mr265394waa.8.1217970641470;
        Tue, 05 Aug 2008 14:10:41 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Tue, 5 Aug 2008 14:10:41 -0700 (PDT)
In-Reply-To: <20080804143838.GD12232@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91464>

2008/8/4 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-07-31 16:29:16 +1000, Daniel White wrote:
>
>> Changes are on my experimental branch
>> at git://repo.or.cz/stgit/dwhite.git.
>
> Thanks. Have merged, and will push out sometime soon.

Thanks, both to Daniel and Karl (for merging them).

--=20
Catalin
