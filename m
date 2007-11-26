From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:25:07 +0100
Message-ID: <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwjaj-0001tm-5K
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbXKZTZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbXKZTZK
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:25:10 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:63653 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbXKZTZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 14:25:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so633030rvb
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 11:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=H8iOjskIDR1Y8G9i5ByKFK0owfGQpwF8VS/hPMYWukc=;
        b=rZNU0ENqxFQgqGhDbTVZi3cbIzMPZNJAWN0BcU/m+N2OEJ1jveTKsxtRaepF9I6DBvwKymwVWsiSsLKNOgZz6JiNcUbZLZHyYX5fEGu+BeLzpf+QWiJt7WtaUi3m+iQquZhABx402zdsfrvng+3uGmG04+/1o3iXK4X1PQakWug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EU5hQVR9P9Vg+KNf/Vhqu9xH6H/iqjZKJVi+Yqdn9kzkBXMRqRddIEYda3p4c1DVcn88/LsxYc800d7VMn381mtdXVABgucsdbuAWHATnH/1zG1bqVQ8cZCSiOzI3hitWzvy0z0oqMLXvcOwl9SeE1i+dnJb1i9mA6ZiWAuihcc=
Received: by 10.141.205.10 with SMTP id h10mr1389715rvq.1196105107039;
        Mon, 26 Nov 2007 11:25:07 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Mon, 26 Nov 2007 11:25:07 -0800 (PST)
In-Reply-To: <fiet88$68n$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66096>

On Nov 26, 2007 5:46 PM, Andy Parkins <andyparkins@gmail.com> wrote:
> Jakub Narebski wrote:
>
> > If you would write git from scratch now, from the beginning, without
> > concerns for backwards compatibility, what would you change, or what
> > would you want to have changed?
>
> Erm... (it's much harder to come with lists like these lately :-))
>
>  - "git-gui" would be written in Qt (ducks)

But...wait...Qt would require...(I'm scared to say!)... that awful,
painful, hopeless thing called C++. Probably you didn't mean what you
said ;-)


Marco
