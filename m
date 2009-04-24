From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 09:33:49 -0500
Message-ID: <b4087cc50904240733u53a2c9a0o3d0943dc7de38324@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org>
	 <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com>
	 <20090423201636.GD3056@coredump.intra.peff.net>
	 <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com>
	 <20090424141139.GC10761@coredump.intra.peff.net>
	 <b4087cc50904240730n42e605e1od37d88d43e00f142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 16:35:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxMUw-0006z4-2D
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 16:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbZDXOdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 10:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbZDXOdv
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 10:33:51 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:58571 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbZDXOdu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 10:33:50 -0400
Received: by qyk16 with SMTP id 16so2258351qyk.33
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YDNUZ7wJWVcqPM9EzdGbkfLwXqkNhuV+PLNC5xGHctQ=;
        b=uoeIP4MTFMJYbxQ36CDsbndFfSVFU/HBADenLTTxeBNs2vI91Hkt0MRZ4cIvnt3RRw
         SuF5TErOnOWquD7Lr2UtRF2scjgK6dkyfez05W4UYSFehawBYIZa9zTSpkq9/3n0CjLc
         n5cN0lKc3HvJtPiyRI5qvjwCUTpAOwU2XjwzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bzctI+ENN9tpqztyUSRDwZHROw+11ArTyx4Ztpff30OLuPaMh2P6Qc/YVk2Rla6zPt
         CgKzBWjaKtUr8ula483HCTk6Hm+cqc2EFa/4uCW/XWXgu21CVvTBHY0qTsU8uc+747fA
         HdZanoCRJqjNHl9ZVB1vVdociRAzs+TLs4Xyo=
Received: by 10.224.67.78 with SMTP id q14mr2807271qai.162.1240583629202; Fri, 
	24 Apr 2009 07:33:49 -0700 (PDT)
In-Reply-To: <b4087cc50904240730n42e605e1od37d88d43e00f142@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117444>

On Fri, Apr 24, 2009 at 09:30, Michael Witten <mfwitten@gmail.com> wrote:
> there needs to be
> documentation solely devoted to understanding git fully and precisely.

A user should be able to read from top-to bottom in one-pass----no
jumping around or later clarifications.
