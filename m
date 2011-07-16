From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Google Code supports Git
Date: Sat, 16 Jul 2011 22:44:34 +0200
Message-ID: <CAGdFq_h4E75LDWkQjkp_DvOAWUC_H+2KEvWMeGviPuFSJWGu+w@mail.gmail.com>
References: <CACsJy8BMK4UqVVNnhs6riVSS-OKcFKT9=XScrAw5nK2FH_u92A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 16 22:45:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiBjy-0000Tf-Ju
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 22:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667Ab1GPUpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 16:45:24 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53760 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab1GPUpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 16:45:14 -0400
Received: by pvg12 with SMTP id 12so1947566pvg.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hdhzTcODwc/+LqhNU0g8SPtvDLnFxnqo5GYuR8+NUu0=;
        b=KK1LipyjllaYDGvB8W7AvL/rut/vt42k0zbeEM0umHyGg0nmPDYPEKmWnmPvl8nbgc
         u1mI84DS2yHL0MU7EKkrdYNAEI0RAIk3Y7b7QYc+o1/f63nh2FL8fRFYprPCLk8eBpcw
         W2+GpCIy/cPEnjF2rA0pGyNOQseQ2rA78FwNU=
Received: by 10.68.26.138 with SMTP id l10mr5897053pbg.317.1310849114102; Sat,
 16 Jul 2011 13:45:14 -0700 (PDT)
Received: by 10.68.49.39 with HTTP; Sat, 16 Jul 2011 13:44:34 -0700 (PDT)
In-Reply-To: <CACsJy8BMK4UqVVNnhs6riVSS-OKcFKT9=XScrAw5nK2FH_u92A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177284>

Heya,

On Sat, Jul 16, 2011 at 12:24, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Just out of curiousity and because I happen to know we have Googlers
> here. If it's not confidential, are there any changes in git to make
> it work with Google Code? I am particularly interested in whether
> Google modifies git to use bigtable (or cassandra, I remember Shawn
> had a prototype).

If nothing else, the "hg on bigtable" talk from I/O 2008 is probably relevant.

http://www.youtube.com/watch?v=ri796Hx8las

-- 
Cheers,

Sverre Rabbelier
