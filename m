From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Gource - new GL Visualisation for git repositories
Date: Wed, 16 Sep 2009 14:06:38 +0300
Message-ID: <94a0d4530909160406x39da12d5x12a1873daed4d2b@mail.gmail.com>
References: <4AB0858E.6040805@vilain.net> <20090916064028.GA9482@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 13:07:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnsLm-0000Zp-3O
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 13:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbZIPLGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2009 07:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbZIPLGg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 07:06:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:64937 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbZIPLGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 07:06:35 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1550834fge.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 04:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aX4ey/RMNIKahsIcRIREKcvFm9ui1jP0xwU4U30xZDw=;
        b=p1HUVBf5SsWqB+99CXv7BnZrUtVcwNaFvPoPyWOEhxHFTKAmwwvLpkK/GXfw3av5Zw
         ymDg/jW1DP1KEmgc64G3IxBUMa2FsCjy1WtmXOZ5Umpj2AlaI166bQxmFm0PLmNw6/+n
         sJ//VbqS/t42dDBCLlcbKaKXxM1BTp+rUQquk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P+8sjIdQb/YjDXxtqlG6pRKtssPDb9ynEU4ZpazjMf2/j4kdiRKyjdetm7ajc3ZvR9
         ksO6AhFlhDQbM1nemmynAZ5GAMP5q3H2klXTXCafzw9/QvybgnP91e0nnoTBw9s3wJVQ
         Mvr78HYUN+gS7X5YpzumUp/6G+7k4RfJtwHwI=
Received: by 10.86.41.19 with SMTP id o19mr3917214fgo.45.1253099198308; Wed, 
	16 Sep 2009 04:06:38 -0700 (PDT)
In-Reply-To: <20090916064028.GA9482@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128640>

On Wed, Sep 16, 2009 at 9:40 AM, Mike Hommey <mh@glandium.org> wrote:
> On Wed, Sep 16, 2009 at 06:28:30PM +1200, Sam Vilain wrote:
>> A little fun candy to be had here:
>>
>> =C2=A0 http://www.youtube.com/watch?v=3DGTMC3g2Xy8c
>> =C2=A0 (HQ version coming, once processing completes...)
>>
>> Gource is a visualizer written in C++ which shows you the developmen=
t of
>> the source code over time graphically. =C2=A0It's pretty neat. =C2=A0=
Home page at
>> http://code.google.com/p/gource/
>
> Code swarm (http://vis.cs.ucdavis.edu/~ogawa/codeswarm/) gives nice
> results, too.

And the ruby version too :)
http://www.youtube.com/watch?v=3DPxjLbj8oT1k

--=20
=46elipe Contreras
