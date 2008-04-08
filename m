From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: auto insert history info into source files, at commit?
Date: Tue, 8 Apr 2008 21:00:49 +0200
Message-ID: <8aa486160804081200s163a40bcmf3f2282e0ba00dd6@mail.gmail.com>
References: <16562665.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: oxcrete <oxcrete@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 21:01:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjJ4b-00036T-R1
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 21:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972AbYDHTAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 15:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757177AbYDHTAx
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 15:00:53 -0400
Received: from ti-out-0910.google.com ([209.85.142.186]:28003 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbYDHTAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 15:00:52 -0400
Received: by ti-out-0910.google.com with SMTP id 28so873825tif.23
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WoSbq286OP+TESaQzdVPRPQVEHAP6Ku7im5GKtDdi7A=;
        b=K53xlBkZsTXcN04mYPpEmZiYyYGbwtl5uTtdZF4t3ucYsAVw+BHWfI3DJJMI2RIFQs6Yu1dE6kDvz14yfbXhZpme7vHVQBz8eYfXdfMOTZXxI5Y5vTHoNRabmBUQmGNORKo+6xNMoWSsqhVj2WXtxPeWArL+ATg+xpWHahuMn1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZcB6/r5oTw5ehtKsrQI7YU2QruiSB1xiwcIARQ1CzYjci8334T6c6bt9YbDLhWAL7fc3jhiy50EW8BO/f57ecKRLEzGnp+TLRK7bnPpbdVlTrpU2J/ZSzvuO8q6b7XlrarMD+H2bZXuY6bRx+tS4U9mydcf9XFFRIusa21V/pNk=
Received: by 10.150.230.15 with SMTP id c15mr1052929ybh.218.1207681249065;
        Tue, 08 Apr 2008 12:00:49 -0700 (PDT)
Received: by 10.151.14.14 with HTTP; Tue, 8 Apr 2008 12:00:49 -0700 (PDT)
In-Reply-To: <16562665.post@talk.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79017>

On Tue, Apr 8, 2008 at 6:03 PM, oxcrete <oxcrete@yahoo.com> wrote:
>
>  How do you do this with Git? I couldn't find it in the documentation.  the
>  standard $Log, $revision... didn't seem to work. I'll take an RTFM answer if
>  you can point me to the right section in the manual. Appologies, if this was
>  posted before - couldn't find a good regex to search this topic.

http://git.or.cz/gitwiki/GitFaq#head-4a0afe71a2bb7734777a8b0b345e0308aefdbd40

Santi
