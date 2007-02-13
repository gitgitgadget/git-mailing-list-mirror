From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH/RFC] Have git-cvsserver call hooks/update before really altering the ref
Date: Tue, 13 Feb 2007 18:14:39 +0000
Message-ID: <200702131814.41512.andyparkins@gmail.com>
References: <200702131512.45412.andyparkins@gmail.com> <7v7iumymvq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 19:17:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH2Do-0005iD-Di
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbXBMSRm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbXBMSRl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:17:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:24693 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbXBMSRl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:17:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so304704uga
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 10:17:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G7eADmk2P14APKI0S5has7Pd0CCjNBUEjNSYliZMQiiAGvQdI2PRy7624zFZbmOR99PYnCmR97cOvWWG2UwoXjOWTCiwRBG8xlzY3ZJpnxkjCmjekMzEPCest5vCTJArn9PFSohK4wsRZ7hlfivK/ca81NO1jEwgPtOK7v9Ef/o=
Received: by 10.66.239.18 with SMTP id m18mr855274ugh.1171390655760;
        Tue, 13 Feb 2007 10:17:35 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id e33sm12521709ugd.2007.02.13.10.17.32;
        Tue, 13 Feb 2007 10:17:33 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <7v7iumymvq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39572>

On Tuesday 2007, February 13, Junio C Hamano wrote:
> As a principle, I am in favor of this.  Perhaps post 1.5.0 after
> hearing what real cvsserver users have to say on the list.

Am I not a real user then? ;-)  Cool - I /love/ being imaginary.

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
