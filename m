From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Thu, 23 Apr 2009 19:31:30 -0500
Message-ID: <b4087cc50904231731p7a3cb652g18dbb2cf5744111f@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org>
	 <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com>
	 <20090423201636.GD3056@coredump.intra.peff.net>
	 <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com>
	 <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 02:33:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx9Ln-0001JD-Rv
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 02:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbZDXAbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 20:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbZDXAbd
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 20:31:33 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:42081 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbZDXAbb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 20:31:31 -0400
Received: by qyk16 with SMTP id 16so1715137qyk.33
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 17:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P4rrjCK7ZO7PzMB4kBZja6ITn4c0EwBj39jLvVa73UY=;
        b=vS8xa/Uc0gnkg15OsJtqr6WPVU39OVJqBuSlaFC/s9Sw/SnBlOcfZfuXR3xQ7cTCMx
         8zWuIF8HdMFi+H27LY527Dae5mFfJRpSEJ+ZgjKi52wyKuovhNP94UlHVRlU0Lmr9XDY
         b3ykAhmuLw8NdriAnkWb9wwv8bSLHEj3lgApk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Xgw1F8vJG9E9CmMJUSt33kIpe4gABpC2wpUNkZvXVlUPFej16sk9S9tOPgyMF+FVwF
         tSbCrhv1U2CcasUPq0kOEYeMmZGQgn7KMcWrpw+hM5clRFlBH5zoUxC1fl1iebZIkJpd
         I5HwV/PsCcg0HDSUMey3cwL3qIAL75z5ain5c=
Received: by 10.224.10.208 with SMTP id q16mr2092177qaq.387.1240533090974; 
	Thu, 23 Apr 2009 17:31:30 -0700 (PDT)
In-Reply-To: <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117400>

On Thu, Apr 23, 2009 at 16:31, David Abrahams <dave@boostpro.com> wrote:
>
>
>> However, a discussion of blobs, trees, commits, objects, and
>> references isn't necessarily low-level. It seems to me that it is a
>> high-level understanding of the git world. Without those
>> *definitions*, people are left to their own wrong, inconsistent
>> thoughts.
>
> 1000% agreed.

I think this is a case in point:

    http://marc.info/?l=git&m=124052299832318&w=2
