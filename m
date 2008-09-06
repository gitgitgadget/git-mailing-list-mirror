From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain
Date: Sat, 6 Sep 2008 16:04:06 -0400
Message-ID: <e06498070809061304v368faf66tf5e5a153212306a8@mail.gmail.com>
References: <20080906150723.GA31540@dervierte>
	 <m38wu5p9q4.fsf@localhost.localdomain>
	 <e06498070809060912q2f7ed0cflb02e3efc7b81976e@mail.gmail.com>
	 <200809062101.28672.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, blix@sophiasuchtig.com
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 22:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc42Y-000770-G1
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 22:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbYIFUEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbYIFUEI
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 16:04:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:55141 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbYIFUEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 16:04:07 -0400
Received: by wr-out-0506.google.com with SMTP id 69so962656wri.5
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 13:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=S3k3Cm2y04dXk86tPSoSJaBWFDBTcGs+ycYiqD19H/A=;
        b=VDBFsHM5sjNepP4qCP4PcLNCKwTJCde6NUXLqRn5wgZMqJPCmN2XA2PFcmDrHhac1w
         NDQ6hgnjJzEk0f38uOTLU+CCYC3gbcpamTho6iOAM9LMse3BJ7G7ALlINZBW8JpjDO9w
         EazSxJGHsaXlFo7ZefozbxFTLQ+HfLu5IKe7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=e33crf3KFm2o+jf3K/BOk7iiowM16vnmYPurI/wBitpEWqJhVDmBM37Yo1xgjF6k50
         0+ixAi9o8OIzIm0MgVdqQzwlj27eRUBSfSokFYV4X1A0WVcRRus0+dVJ9exkhmeY7rVH
         Xhr5iAAKNt722avLmhYYTzaQF3cT+qlq0vv8U=
Received: by 10.90.98.13 with SMTP id v13mr16865094agb.54.1220731446316;
        Sat, 06 Sep 2008 13:04:06 -0700 (PDT)
Received: by 10.90.25.17 with HTTP; Sat, 6 Sep 2008 13:04:06 -0700 (PDT)
In-Reply-To: <200809062101.28672.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95097>

On Sat, Sep 6, 2008 at 3:01 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> To my knowledge, Pyrite does not support plugins.
>
> As far as I know Pyrite is one-man work.  Why not to join efforts,
> bringing those two projects together?  Both share the same language,
> Python.

That's an interesting idea and something I'd like to pursue.

> By the way, please take into account
>  http://en.wikipedia.org/wiki/Yap_(disambiguation)
>
> Most commonly known YAP is I think Yet Another Previewer, which is
> the name of the DVI viewer included on the widely used MiKTeX TeX
> distribution for the Microsoft Windows platform,
>
> YAGP, or YA(G)P, is I think free of such conotations.

I was not aware of that.  I'm not firmly attached to the name I've
chosen, but I would like the command to remain short (2-3 letters).
Maybe call it YAGP and use "yg" for the command?
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
