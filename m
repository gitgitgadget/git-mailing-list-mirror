From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: Re: Anyone have access to 64-bit Vista?
Date: Tue, 27 Jan 2009 14:41:04 -0800
Message-ID: <83d7aaa40901271441h47c98edepc16f5026de636134@mail.gmail.com>
References: <83d7aaa40901270130g3bebb3d6we4839b567f310e46@mail.gmail.com>
	 <20090127122456.0df531c3.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 23:42:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwdb-00055v-FC
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbZA0WlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbZA0WlH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:41:07 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:35638 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbZA0WlG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:41:06 -0500
Received: by qyk4 with SMTP id 4so7580122qyk.13
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 14:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=/3nd7PvciUVgb/TMJ0XpAj6dyifGIxEqXc3LkSOyyp8=;
        b=UM0HScw8I9KEJXE8xPkXWvaG1cUTZ9DX3QNsvtbyNwEPU0X7a8yJ/yw0of7uxfYF9Y
         CIpRvYUxbiaTa8+VAL0EtDDXKWnvJQbEcj99V6yumy9jShdIrunhX5AOwMwqYMnxc/rA
         XxNJUP+GR8xCtxPJKNC36lCE/+6H508s+PyyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=qp8POTDg2PJafKwCaEuZqfz2FVDyMUMXYQihaq6PFgzlh/aeqb81I79YL8FNjnnPKq
         lN9n4Zx+KpkQcqOC8Z4wVFcBP6wG0itglds97pWK9zRwVuufDPiMYd4nY35LQGGP9blU
         74QXVlMdf6KiFMr5hbCd6HR3a6JpMDYOn+FG0=
Received: by 10.214.113.11 with SMTP id l11mr6090304qac.190.1233096064511; 
	Tue, 27 Jan 2009 14:41:04 -0800 (PST)
In-Reply-To: <20090127122456.0df531c3.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107409>

On Tue, Jan 27, 2009 at 10:24 AM, Stephen Haberman
<stephen@exigencecorp.com> wrote:
> It kind of works on my Vista 64-bit system--I do not see the shell
> extensions in the native Windows Explorer (which is 64 bit), but I do
> see the shell extensions in an Explorer replacement I use (Xplorer2)
> that is 32-bit.
>
> I've seen other oddities in 32-bit vs. 64-bit programs--e.g. my alt tab
> replacement (Joe), which is 32-bit, works great with 32-bit programs
> but cannot remove focus from 64-bit programs (IE, Windows Explorer,
> etc.). Ironically, very few of the programs I use are 64-bit, so I get
> by with the alt tab replacement.
>
> - Stephen
>

Thanks! It seems that 64-bit explorer.exe will not load 32-bit shell
extensions. At least now I know I'm not going crazy. :)

-Geoffrey Lee
