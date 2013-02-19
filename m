From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 13:42:35 +0530
Message-ID: <CALkWK0nnkfrHi-0=c-bXdBHaOeBsCdccZDJZX5LDs0dT=SsReg@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
 <7vip5p9rtm.fsf@alter.siamese.dyndns.org> <CALkWK0=s4XX0mmUTAcNBHyqdrryhMYvhtrNZCFFccJJBUUVdUg@mail.gmail.com>
 <20130219072512.GI19757@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 09:13:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7iKL-00056m-3C
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 09:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412Ab3BSIM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 03:12:59 -0500
Received: from mail-ia0-f173.google.com ([209.85.210.173]:47326 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3BSIM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 03:12:56 -0500
Received: by mail-ia0-f173.google.com with SMTP id h37so5865520iak.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 00:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9DspgR7/UKAbpBVA90YRci04F9xLYSsGC3qcVf1o6Ps=;
        b=gWg/NxAql6MMj+K8NDy8ToOGSq+c6zj9Kwwu8TJG6c8QZ9e8sNhb+TcYWbVvU3XFWr
         gkRPvIJKEoVXi+JsMdkO3M4WQanQ9QP1r5qVxfTvlMi5kGIMi886tlL7Sv8gBjB6Ctvr
         gliu1CCrxxMu0f+K0nbRAtYrmc76FnJxRUtvw5HtnVQJMxFs9E98X6zs845JabRGcx/n
         +sUVYnEyYs0n6NvxUdU+sUjvQK7VL9eOsfjU/7529BVHp5dfjCbnOBGZQltyp5j94A7J
         aQtVkokNgFDaT0f7l+PWpNxpmoWguiZhdPMHSj6XpzMjdxB81/m6HcRjvPd2AsC3gIIo
         CTVQ==
X-Received: by 10.42.204.79 with SMTP id fl15mr7045093icb.57.1361261575440;
 Tue, 19 Feb 2013 00:12:55 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Tue, 19 Feb 2013 00:12:35 -0800 (PST)
In-Reply-To: <20130219072512.GI19757@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216574>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> The short undiplomatic version of that is that our mentors suck (I'm
>> not pointing fingers, but that's what I infer from failing projects).
>
> Hold on a second.  I'm not remembering such a grim outcome with 100%
> failure from prior summers of code as you're describing.  Before I
> start beating myself up, I guess I'd like a little more information
> --- is there some specific project or statistic that you're thinking
> of that brings you to that conclusion?

In retrospect, I might have been unnecessarily harsh there.

One of the main measures of a mentor's success, in my opinion, is
having his student stick around after the Summer of Code: the mentor
is the student's primary link to the community.  There have been 4~5
students every year, times 6 years (is that how long we've been
participating?).  How many of those students have felt part of the
community?
