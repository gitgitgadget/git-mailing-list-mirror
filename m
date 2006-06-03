From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Sat, 3 Jun 2006 00:28:20 -0400
Message-ID: <9e4733910606022128h23ff94fbg3fcb4fa191254b5a@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 03 06:28:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmNkg-0004Iv-09
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 06:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWFCE2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 00:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWFCE2W
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 00:28:22 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:55464 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751147AbWFCE2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jun 2006 00:28:21 -0400
Received: by nz-out-0102.google.com with SMTP id s18so771060nze
        for <git@vger.kernel.org>; Fri, 02 Jun 2006 21:28:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f5TdDFtqt+pnWAzWumKRda2eO4xXEMzPjila14L3q2I4mNEoK4QFpeUwo03KbZ02XxvKpxj3Pbv/WVPtDIKhwxaRm3H+XbcpqA/8Ea2Rywfp6yxJirXrHyEn1PR3Ps3BCEmiGi5XyDLwgVp2aUAkejKn0djsnxEr7bFl12sePkk=
Received: by 10.36.68.4 with SMTP id q4mr2466919nza;
        Fri, 02 Jun 2006 21:28:20 -0700 (PDT)
Received: by 10.36.39.3 with HTTP; Fri, 2 Jun 2006 21:28:20 -0700 (PDT)
In-Reply-To: <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21184>

On 6/1/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> With the attached patch you can parse the entire Mozilla tree. The
> tree has over 100,000 files in it and about 300 branches.

I was a little low with these counts, more like 110,000 files and some
parts of the tree have 1,000 branches. Total tree size is 3GB.

-- 
Jon Smirl
jonsmirl@gmail.com
