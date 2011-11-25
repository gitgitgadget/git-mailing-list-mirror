From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: what are the chances of a 'pre-upload' hook?
Date: Fri, 25 Nov 2011 08:46:45 +0530
Message-ID: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 04:16:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTmHW-0007dZ-Ax
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 04:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab1KYDQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 22:16:47 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58930 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab1KYDQq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 22:16:46 -0500
Received: by ggnr5 with SMTP id r5so3090847ggn.19
        for <git@vger.kernel.org>; Thu, 24 Nov 2011 19:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LMmlUBB7HQ7tkv7vXrqj804hTtVVEPs5tttlnJbrd2Y=;
        b=EXhzQvkfh0KpKP4Uka2UiGmZBHtAxKqb23xdbIn8dpB7KkygZt/G2/kIOHXv+1cta8
         e6AmuHzFoa+1x7X6HnIl/wIV770L+H5+noBgdduy16f/QCk6AVtcYZJkuWKFgFBwcwGy
         +ZJ2Fp6T0yFQpk6MSnMNc//jWCZA97VTAbtyo=
Received: by 10.182.13.3 with SMTP id d3mr9960438obc.20.1322191006037; Thu, 24
 Nov 2011 19:16:46 -0800 (PST)
Received: by 10.182.6.41 with HTTP; Thu, 24 Nov 2011 19:16:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185923>

(...and/or a post-upload hook)

Has this ever come up?

-- 
Sitaram
