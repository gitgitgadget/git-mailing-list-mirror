From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [egit] Git repository with multiple eclipse projects ?
Date: Wed, 25 Nov 2009 20:53:19 +0100
Message-ID: <1259178799.4336.4.camel@yann-laptop>
References: <20091125164734.GF21347@linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:53:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDNvh-0004IF-8x
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 20:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759624AbZKYTxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 14:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759610AbZKYTxS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 14:53:18 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:32956 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759612AbZKYTxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 14:53:18 -0500
Received: by ewy19 with SMTP id 19so52395ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 11:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=3A4fiPBhtvnM3t4SdV0kKgvhrmqoIDzEuicFT4HfYjo=;
        b=v0hxe/IGyZCazzSPKA3SCixczsCpAd3dTHkK5X27yuJWilKI3qXDorJseFWYtFRp+M
         CPGzrrS6pKZRDL8blQpfvxwScBU30UGrjrkEloY0CR8PeXCa71BCBJ9GcOIXfFqiriSM
         SKdJNj1Dyj8vBJx0hDBQzYJAizDmJjUMFMlE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=xYEaXJXzBNPCMjguQjP1V/gcFy0IHvznolWPnbrYFTXtbimFebcZXyTS++7me7ogCj
         +Tiwn7WxE9MQgb+oLJZDJGNjW+dV8moUqRfk8TS08ItWAsvCW7Rfv3kPQQ/UVTzCJgnY
         KVyD9iStDnKEzrQSRfmwljfYl1RRdudCuoShk=
Received: by 10.216.93.18 with SMTP id k18mr2536214wef.218.1259178802149;
        Wed, 25 Nov 2009 11:53:22 -0800 (PST)
Received: from ?192.168.2.100? (dslb-188-103-198-242.pools.arcor-ip.net [188.103.198.242])
        by mx.google.com with ESMTPS id n12sm114002gve.29.2009.11.25.11.53.20
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 11:53:21 -0800 (PST)
In-Reply-To: <20091125164734.GF21347@linagora.com>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133665>

Le mercredi 25 novembre 2009 =C3=A0 17:47 +0100, Yann Dirson a =C3=A9cr=
it :
> It also does not look like it would be possible to use the "share"
> functionnality to setup such a repository from multiple projects (or
> from a project set), right ?

The last time I worked with egit, it was not yet implemented.

Yann
