From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Possible feature request for merge and pull
Date: Thu, 29 Jul 2010 00:22:21 -0400
Message-ID: <AANLkTikYS97TKOcNoS42rczJJ6bUztQF1LbCa4qGk0xK@mail.gmail.com>
References: <AANLkTim6JAPrSVaSaGZ72xtfFnUUcYeWT8vpL3rYuwki@mail.gmail.com> 
	<AANLkTinRvq71GS5WVdWs9zP5QSJ=TjCWBgTfRGn2Qub0@mail.gmail.com> 
	<AANLkTikA2jWu76aPUNG+B7Nwc9eDzoU93VcGvUFWR0Ri@mail.gmail.com> 
	<20100729010341.GA25732@coredump.intra.peff.net> <AANLkTikP+5GxyWbXNcKeOtQoOEGAT9v313jAum+q-1LV@mail.gmail.com> 
	<20100729012723.GH29156@dert.cs.uchicago.edu> <AANLkTinPcH-urWJJ_UELA5Kj=m3zKKLB8yGuvj6b03jw@mail.gmail.com> 
	<AANLkTimt7Q++tAjNc7iZSUTdtaYphg9=Dtmaco3HUJSc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 06:22:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeKds-0004BG-AM
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 06:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845Ab0G2EWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 00:22:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55106 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab0G2EWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 00:22:42 -0400
Received: by wyb39 with SMTP id 39so66482wyb.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 21:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=KAvpU/TrR1uxCwepYik/8TzGGc0quw762tlTM6ofnuM=;
        b=NcaA72cia3C8TIC5d+7D/v81BI8rPTW8z8li8OwoEcz6KRaSkLsCfC+YFHLgom8HKW
         Y5fHIF0Pmv+hVw7JoEH+pJO/jpMJc2rvmxDmtQSyrR3ssCovfgm7nGO0KBJhmhNFcnoQ
         yetQwTofFUki61Cqc2C17+EkRmLrD594u3qFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=oIXdkC1/tpCpUtL5fTHJjVT7ClmEwSj65wbx1Cp2KE1j9A0MKT28lGBLCgg/bXIpOW
         5W0Czq9alfYrfOortsSX+DOXuXN5mcT8NPSNjOkTSwQe1HQR9G3wXjSTnYoJPsPK8xx2
         h5lBUn0zzFyRUOi4+DCk256c6w0wZrhn1/dQ0=
Received: by 10.216.87.208 with SMTP id y58mr11572528wee.82.1280377361240; 
	Wed, 28 Jul 2010 21:22:41 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 28 Jul 2010 21:22:21 -0700 (PDT)
In-Reply-To: <AANLkTimt7Q++tAjNc7iZSUTdtaYphg9=Dtmaco3HUJSc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152158>

On Thu, Jul 29, 2010 at 12:20 AM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> New version works great with merge. Thanks guys! Now I'm wondering if
> we could bring -m flag to pull.

I'm sure this is also an easy patch if you're in the mood to contribute it :)

Perhaps there are reasons this was left out originally, but I'm
guessing it was just that nobody expressed any need for it.

Have fun,

Avery
