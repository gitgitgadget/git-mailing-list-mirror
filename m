From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Fri, 3 Dec 2010 20:03:59 +0700
Message-ID: <AANLkTinRHRqpLZg4awT4KwjvXDsQrwMprG=U1vgcZswo@mail.gmail.com>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Fri Dec 03 14:11:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POVQ2-0006UD-FH
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 14:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab0LCNLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 08:11:15 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:61800 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379Ab0LCNLO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 08:11:14 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2010 08:11:14 EST
Received: by ewy10 with SMTP id 10so5435700ewy.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 05:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=XJxr1YbASe+EyhczObxfSuVVAJiIQg2GGvGiwevvUKM=;
        b=YNOCZJBPfFn/GaxWfxIrLHdWLPvaI0Dw3q03qM5GlA6SbqkSf5Uo3xsHOeVXeIGg9l
         RpFqjSX/3w1dS1tDpQ0BwvtzDKbIiMmc65V/hFMq80Ixz0WfrkuVA9L/eLDy7D7OyN5X
         6x4/g00fnIOgWQMIBz/Utu+nsZUpWv3fX3a4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Q2suBUyo2hE3lK25y4G1yYSw1oJXVSE6jZWDHO/Ux4x0YPXHCCjfsE63+Ur4c5UnoC
         /qpfTxBtqd4mBwBlrMVKz4bD4oAOYSIEmr6jf1RRywE+KIQz/NTquaGMRTg4ALIEzkOJ
         jhuAdt2qG2FCVj8XtzpjW8/gWHI4h5ync52eQ=
Received: by 10.216.240.75 with SMTP id d53mr1600189wer.4.1291381470172; Fri,
 03 Dec 2010 05:04:30 -0800 (PST)
Received: by 10.216.167.193 with HTTP; Fri, 3 Dec 2010 05:03:59 -0800 (PST)
In-Reply-To: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162798>

I think you can start a fork now, with everything sorted
alphabetically. Massive changes do not fit well in git development
model. It causes lots of conflicts.

I would like to hear any user feedback from such a fork. If it proves
actually helpful for  end users, it would be merged eventually.
-- 
Duy
