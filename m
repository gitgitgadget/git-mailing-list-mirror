From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3] git-submodule: add "sync" command
Date: Wed, 27 Aug 2008 01:43:03 -0700
Message-ID: <20080827084302.GB1422@gmail.com>
References: <ebeb5aba6f679e1259a011bcc245bd723c6cf8d1.1219606749.git.davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 27 10:52:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYGkt-00062o-84
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 10:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbYH0Iuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 04:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbYH0Iuu
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 04:50:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:24260 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbYH0Iuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 04:50:50 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2546541rvb.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ctcrKK5O25ZpfnyHP45rZ46+q4UJ8WbeqjzD0t12Pho=;
        b=gy+epUPllmGCXVTtDia1SbzJnCgARIH4WFW7ajDw00gnmMv0rcBDwIwceD/91i3HQ2
         YPI71roHbpoCn9Ge2+GzYcEVhDj6Ihipe8yS/i0ITayPed3uzWG3Fe5+JKEYkHey+46U
         gXcwVG9lucpY8DcCw0y7KYjqrPozMhmHfSK8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        b=c+MlXjIcZyVeylTs23TyT5PS2GGd+53fKPL8fcbtcWsN1wy6yEsXca4GKM6pQD0Lov
         8l6WznX6ww945bzuMBbgmiuemK8AG66pX1KBX406GAJ8/l4pNO//IanlrDzO2WVkbE3p
         N3lPoveq9FhUe/KMmB9+swQzH/A+YgKXWwsbc=
Received: by 10.141.69.1 with SMTP id w1mr3434275rvk.147.1219827049792;
        Wed, 27 Aug 2008 01:50:49 -0700 (PDT)
Received: from gmail.com ( [208.106.56.2])
        by mx.google.com with ESMTPS id l31sm11465595rvb.2.2008.08.27.01.50.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 01:50:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ebeb5aba6f679e1259a011bcc245bd723c6cf8d1.1219606749.git.davvid@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93877>


Hi Junio
I'm just checking up on the status of this patch:
http://thread.gmane.org/gmane.comp.version-control.git/93535/focus=93557

I believe v3 addressed all of your comments from that thread.
Let me know if there's anything else I should consider.

Thanks,

-- 

	David
