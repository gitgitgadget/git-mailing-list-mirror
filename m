From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Wed, 7 Jun 2006 11:30:40 -0400
Message-ID: <9e4733910606070830g24a08771i1a332552a95283d1@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
	 <1149219593.5521.34.camel@neko.keithp.com>
	 <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
	 <1149220518.5521.43.camel@neko.keithp.com>
	 <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
	 <20060602041107.GA5429@spearce.org> <1149223164.2443.33.camel@dv>
	 <9e4733910606012144p5f4fda26sdc2de2cc77b71fe7@mail.gmail.com>
	 <df0b33100606070202w581ff581i435056f0fbc197f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Pavel Roskin" <proski@gnu.org>,
	"Shawn Pearce" <spearce@spearce.org>,
	"Keith Packard" <keithp@keithp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 17:31:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnzzY-0002V8-Tc
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 17:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWFGPam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 11:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWFGPam
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 11:30:42 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:33563 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932264AbWFGPal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 11:30:41 -0400
Received: by nz-out-0102.google.com with SMTP id s18so231432nze
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 08:30:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h+VOSTcZmEZ9W2fxQCHQTRYdwFtsGHe1g6KmDUCNXzZrY8aWfGG3c0ztp9q0Kv6G1vbO4pcBOJ67Chu0eQ0yMw/djPGQt74t9dbWfVvomvH3TkRrKQ8qZ9NE6Jbe5HphutTrtf2IVgWbxK5DNr3w5umuOD2lqGSwnio8MZQt2mo=
Received: by 10.37.12.54 with SMTP id p54mr861418nzi;
        Wed, 07 Jun 2006 08:30:40 -0700 (PDT)
Received: by 10.36.37.15 with HTTP; Wed, 7 Jun 2006 08:30:40 -0700 (PDT)
To: "Igor Bukanov" <igor.bukanov@gmail.com>
In-Reply-To: <df0b33100606070202w581ff581i435056f0fbc197f8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21438>

On 6/7/06, Igor Bukanov <igor.bukanov@gmail.com> wrote:
> On 6/2/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 6/2/06, Pavel Roskin <proski@gnu.org> wrote:
> > > Dependency on Cygwin, Perl and Python is too much.  Windows is becoming
> > > a legacy system in some circles, and it may run on legacy hardware.  Yet
> > > it's irreplaceable as a testing platform for many projects.
> >
> > 80% of Mozilla commiters are running Windows. Some are OS bilingual
> > but many are not.
>
> Mozilla build system on Windows requires Cygwin and there are 198 Perl
> files in Firefox tree. So it is only Python that can be problematic.

Other people have sent me mail saying this may not be as big  as
problem as was thought, only documentation people on WIndows may be an
issues.


>
> Regards, Igor
>


-- 
Jon Smirl
jonsmirl@gmail.com
