From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/8] Provide a build time default-editor setting
Date: Fri, 30 Oct 2009 08:17:50 -0500
Message-ID: <20091030131742.GA15034@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
 <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock>
 <20091030103558.GH1610@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 14:08:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3rCw-0002Lt-Hw
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 14:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201AbZJ3NHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 09:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756397AbZJ3NHr
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 09:07:47 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:60711 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204AbZJ3NHq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 09:07:46 -0400
Received: by ewy28 with SMTP id 28so2970850ewy.18
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8qEoQx89xpNbUQc+Xbo+LyJi6ueAquqASC2MsP336BI=;
        b=bnCaMJp8dgQu+PxTUEj9/Bp0FCQf+Er6XfICEDswdJpIZnxn6y7sZW6oDLxX5s7WsO
         EcGSSROhvZCmbF468b9ClwfTpR5ifWSqQk9If9q91tw05XdXtk1R3xch2TCxdngWfAy/
         06+PoTMiADnh6tkQhgM5yGScuICtFarG4ZlQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QH/Fai/3AxGVxv5RTq1njqPk4OScCbkKX5aPWG0eXfIJxrd3Hh+zzhEpJTvbudjrbx
         UhYQHZ1FQCyp13cgK+RhDt7Fak+vKLTwFVfTHwIKswULEtWZ8vYl1bhJx2L9EKxtsBCc
         RSj0OWqHX2FqQnDGevG9YGH37r7os7oZFOZbw=
Received: by 10.216.87.66 with SMTP id x44mr643472wee.96.1256908070778;
        Fri, 30 Oct 2009 06:07:50 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u14sm3360818gvf.3.2009.10.30.06.07.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 06:07:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091030103558.GH1610@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131704>

Jonathan Nieder wrote:

> Signed-off-by: Ben Walton <bwalton@bwalton@artsci.utoronto.ca>

That should be "Ben Walton <bwalton@artsci.utoronto.ca>", without the
extra bwalton@.  Sorry for the trouble.

Regards,
Jonathan
