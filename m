From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Fri, 2 Jun 2006 00:44:56 -0400
Message-ID: <9e4733910606012144p5f4fda26sdc2de2cc77b71fe7@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <1149214075.5521.31.camel@neko.keithp.com>
	 <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
	 <1149219593.5521.34.camel@neko.keithp.com>
	 <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
	 <1149220518.5521.43.camel@neko.keithp.com>
	 <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
	 <20060602041107.GA5429@spearce.org> <1149223164.2443.33.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>,
	"Keith Packard" <keithp@keithp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 06:45:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm1Wu-000689-6Q
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 06:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWFBEo5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 00:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWFBEo5
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 00:44:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:14897 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751123AbWFBEo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 00:44:56 -0400
Received: by nz-out-0102.google.com with SMTP id s18so447222nze
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 21:44:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kwGnzeBFkJjYi0fz/hRTn1MSEe01tsQ6xPi6Y4FWu3ubjS0zKXBcaWEmad1MpHLtXzvTfFPYSi1GMWfBuna/bzw32WnrWa9C3ulQ8pOu1EM6HML1/5cQXjRHZEhT+HMTRZLC4ovMgm4LX6lYXrsKXkcABfyxZVjud1Xl3zeo9UQ=
Received: by 10.36.68.4 with SMTP id q4mr1125694nza;
        Thu, 01 Jun 2006 21:44:56 -0700 (PDT)
Received: by 10.36.39.3 with HTTP; Thu, 1 Jun 2006 21:44:56 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1149223164.2443.33.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21147>

On 6/2/06, Pavel Roskin <proski@gnu.org> wrote:
> Dependency on Cygwin, Perl and Python is too much.  Windows is becoming
> a legacy system in some circles, and it may run on legacy hardware.  Yet
> it's irreplaceable as a testing platform for many projects.

80% of Mozilla commiters are running Windows. Some are OS bilingual
but many are not.

-- 
Jon Smirl
jonsmirl@gmail.com
