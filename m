From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 18:21:34 +0200
Message-ID: <200610201821.34712.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 18:22:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gax7p-0003kq-Ei
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 18:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946423AbWJTQVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Oct 2006 12:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWJTQVe
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 12:21:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:25841 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932268AbWJTQVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 12:21:33 -0400
Received: by ug-out-1314.google.com with SMTP id z34so666109ugc
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 09:21:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ttUam6R8eZIDEzvBF6nv5Ob2AsVU0oxNott6VHfvKSKRCmuZNC97WnhBscpA/pgWaoLgGA7RS9UJex6GghETrHFg7kL3yIf0iES+O/WSGWB88O8x2ZVcdzeIdYILV5m3MTk9OCm/xJIpOvi4OQh76W+sV22wSNHyLdVyvZ0aMU8=
Received: by 10.82.107.15 with SMTP id f15mr726024buc;
        Fri, 20 Oct 2006 09:21:31 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id w40sm1512134ugc.2006.10.20.09.21.30;
        Fri, 20 Oct 2006 09:21:31 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <4538EC8F.7020502@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29501>

Aaron Bentley wrote:

> =3D=3D=3D added directory =A0// file-id:TREE_ROOT

Gaaah, so rename detection in bzr is done using file-ids?
Linus will tell you the inherent problems with that "solution".
--=20
Jakub Narebski
Poland
