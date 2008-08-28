From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Fetch via http and proxy which requires authentication
Date: Thu, 28 Aug 2008 06:30:36 +0030
Message-ID: <4d8e3fd30808272300g58d92dd8pd877d72805bc29c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 08:01:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYaZm-0003B2-1g
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 08:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbYH1GAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 02:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbYH1GAi
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 02:00:38 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:40440 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbYH1GAi (ORCPT <rfc822;Git@vger.kernel.org>);
	Thu, 28 Aug 2008 02:00:38 -0400
Received: by qb-out-0506.google.com with SMTP id f11so636553qba.17
        for <Git@vger.kernel.org>; Wed, 27 Aug 2008 23:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=f98W14MBJGqPbbo/kZKFtzfndUs9dZF5b/5hL0Ut7z4=;
        b=V6o3UUALgGzAPIx8iWATHhr2IKvaoKsc1UPs9Gvx42Y+Co3JdABn/Occ8x1cYs5kc4
         h3Wx3DKj7mh+zMjnr1Q9or3oYVaVL69vOb5KeAKvdOAdJlpDn0XTJSPoO8Sbm/5cDvQ1
         abtBaKZafMJd0HiGb/dvDiGkED4usIjqjAZvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=NBaVxwft2VhGVJYE5vdOVFaBZN4yjRTcZacLgKqikvIt/M3moTJv1cZPxW6nEER9r+
         2PwOdT2RDUA6mxiaIthH+OgLBdF8/Pa64O7BJc4TO2V/Cx0l96rIrhq9RWBw6Y91KEOA
         0ndxZPW2tpSSM1DURgwNd6DTCEKNSTs6/hd4E=
Received: by 10.142.242.11 with SMTP id p11mr316772wfh.198.1219903236868;
        Wed, 27 Aug 2008 23:00:36 -0700 (PDT)
Received: by 10.142.177.15 with HTTP; Wed, 27 Aug 2008 23:00:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,
i'm looking for a way to use git behind a corporate proxy which
requires authentication.
i just need to be able to fetch/pull via http.
i'm using git on a win xp box.
Any hint?

thanks.

regards,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
