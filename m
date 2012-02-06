From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: git-svn: t9155 fails against subversion 1.7.0
Date: Mon, 6 Feb 2012 09:02:28 +0100
Message-ID: <CAH6sp9ORKvXt2_V4UgESTY7Tn2=9ysjWS3dO4eGgxCuZY1a5Yw@mail.gmail.com>
References: <op.v4neh4q20aolir@keputer>
	<op.v4pu1zcq0aolir@keputer>
	<robbat2-20120205T212444-523294742Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Erik Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:02:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuJX2-0002mB-8C
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab2BFICa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 03:02:30 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61711 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab2BFIC3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 03:02:29 -0500
Received: by qadc10 with SMTP id c10so1903369qad.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 00:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qQes64WKUdHUSxEG6P+7CqMoAB7/QlnICBUWhRvbbCE=;
        b=Yvh82vBYiwggmaCRA5PELUOwREhtgVZZubev+y8s3EfB2YVQE2n0rFcXQlvVOir4v3
         3wOZHAfD+wiz0XxJXITlyRv9FHkAgnR4qR52OS6QzMr4eIZLjBK4kgA5T7jbN1PUyZ8b
         8SsdbVyFCF8/lW5oh5ig2h9phAlBP6OF30ZQg=
Received: by 10.224.117.15 with SMTP id o15mr18616867qaq.97.1328515348968;
 Mon, 06 Feb 2012 00:02:28 -0800 (PST)
Received: by 10.224.204.74 with HTTP; Mon, 6 Feb 2012 00:02:28 -0800 (PST)
In-Reply-To: <robbat2-20120205T212444-523294742Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190040>

Hi Robin,

On Sun, Feb 5, 2012 at 10:25 PM, Robin H. Johnson <robbat2@gentoo.org> =
wrote:
> On Thu, Nov 10, 2011 at 07:02:13AM +0100, =C2=A0Frans Klaver wrote:
>> I missed $gmane/184644 in my search for this issue.
> Did you make any progress in fixing this?

I haven't invested time in this, and the tests still seem to fail on
subversion 1.7.x. Maybe one of the people involved in $gmane/184644
knows more?

Cheers,
=46rans
