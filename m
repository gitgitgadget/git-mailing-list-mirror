From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Breaking expectations in 1.7.0, was Re: What's cooking in
 git.git (Nov 2009, #06; Wed, 25)
Date: Fri, 27 Nov 2009 12:32:55 -0600
Message-ID: <20091127183141.GA3544@progeny.tock>
References: <7v8wduksgq.fsf@alter.siamese.dyndns.org>
 <20091127065904.GE20844@coredump.intra.peff.net>
 <20091127144553.GA24366@progeny.tock>
 <alpine.DEB.1.00.0911271536100.4521@intel-tinevez-2-302>
 <20091127153349.GA24647@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 19:21:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE5RE-00029R-DZ
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 19:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbZK0SUt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 13:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbZK0SUs
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 13:20:48 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:49653 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbZK0SUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 13:20:48 -0500
Received: by ywh12 with SMTP id 12so1883931ywh.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 10:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=81rZqx2at9dJg8uCW6QAR++h4RRraJBLl2HZVG2d1oc=;
        b=GpM3YaWuqRSTwiPX/6Cyc1OrtgRIuKiEnBnxwVr+Phzh5+O84cjKFMLhEwMjwWAjmw
         17ZOyLE3k9A7KioRSPNtWpu7UGKDIgLaOiOx2sVPIItMaLmfup4ojTZNP3RJkL+I/Qgi
         Hs4sORd57SOH1x9YrLeeM4ZV3kbLMarQWEyqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=n9n21s2rgjWHIAjYbUNTecrfmwp+Sre8eA+OYNRGjZ//TWOeNQax5HgdYITxFIb3U5
         buWYSxs/b5K5aP18nJIzc6HGIxpp82UdoQ3May4zt+5RYXCzVhrg292jFz+FhvvN/alv
         gN5zcu9uu9CyevLTA6X8TNE1ypZS+CiC0VYJk=
Received: by 10.150.173.3 with SMTP id v3mr2281271ybe.52.1259346050936;
        Fri, 27 Nov 2009 10:20:50 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm763884gxk.4.2009.11.27.10.20.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 10:20:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091127153349.GA24647@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133915>

Hi again,

I wrote:

> I was trained by 1.6.0 and 1.5.0, I guess.

This misses the point.  The big difference is that 1.7.0 is not that fa=
r
away, so it is not the time to tack on world-shaking changes.

So please substitute 1.8.0 or 1.9.0 for 1.7.0 in my message to Peff.

The point doesn=E2=80=99t change, though, which is that I think it make=
s no
sense to add a configuration variable for this before changing the
default.

Thanks for the clarification,
Jonathan
