From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.1
Date: Wed, 4 Apr 2007 10:38:33 +0100
Message-ID: <200704041038.36183.andyparkins@gmail.com>
References: <7v648c7bbn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 11:38:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ1x4-0001tR-5Y
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 11:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992788AbXDDJir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 05:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992790AbXDDJir
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 05:38:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:50172 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992788AbXDDJiq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 05:38:46 -0400
Received: by ug-out-1314.google.com with SMTP id 44so597547uga
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 02:38:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LoXvG6padw6Mri4P69ApYC5nVDCzqUzmbtvA/6cZ36LVWBBHeGxEaL6ERenxu7EMO4ciEh6L64DAl+IfHvGSp9zVznr6YWh+difi7hdgzrMQoDxk8o+UDSR+GlyusKoIPJ+Aih6kMowds9xKxVEfGRoVE0iV1NFnWh1Um2Ax4GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uJbprjnLsD4i1FNPS5gUs4VzX/9/r23N+j6c35Qwk/Ark9WkFNaWfuwJB3vxoAjXKXm7sTBmUhJ2N02eT4KxoXncwgA0DvBziz9VJ9gYr0X5Bj6gmPGLuNcU9Uk4tuU8Qg90KPx4aHbjMfaykOxHXIxlsvaBljXjZwF9VHBVsHY=
Received: by 10.67.116.3 with SMTP id t3mr1308498ugm.1175679521796;
        Wed, 04 Apr 2007 02:38:41 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm840053ikz.2007.04.04.02.38.40;
        Wed, 04 Apr 2007 02:38:41 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7v648c7bbn.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43724>

On Wednesday 2007 April 04 10:12, Junio C Hamano wrote:

> * Deprecated commands and options.
>
>   - git-diff-stages and git-resolve have been removed.

For future reference:

If a feature has been removed then it isn't really correct to call 
it "deprecated".  Deprecate means "to disapprove of" or, in this context, 
that "the use of this feature is discouraged and a suitable alternative 
probably exists".  To deprecate a feature implies that one could still use it 
if you wanted but it should not be relied on to exist in the future.  If a 
feature no longer exists then describing it as "removed" is sufficient.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
