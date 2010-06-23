From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: Splitting Git Repository
Date: Wed, 23 Jun 2010 16:35:56 +0530
Message-ID: <AANLkTimlFeeZtpSYHmfyeY8WZXrUzv0gTp-EBysQFXA3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 23 13:06:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORNmP-0007vT-M9
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 13:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab0FWLF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 07:05:58 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:48459 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab0FWLF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 07:05:57 -0400
Received: by ywh36 with SMTP id 36so3811165ywh.4
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 04:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=BHAsFJ+0UHnzu5ffxQxWuaRF26MqqFXRPiolnM5LXtg=;
        b=qstCI0ce9jFuALHWro09XRiXP12YSVylCIlfxpqqJKoBJ4Xy/jZaZj7je+DdLFMDNM
         tBD4P/Pr8FrkD8GUTcGgoqTxH8BHXHSvlMbwoDsiPGaKzgNF9ZZDKMFaXl5CUiDt2Krf
         +rIde1sDvKF8AV6hZ3lPRbC3ZyDsif6iKlS6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=TOGtZyOPt0BtTEy9NcIRJIK8J6LOHVdMuHWwSwmgWLuCESGOP/YfNPFgcNGWC512G/
         PXjjYgspCM8wRUMV6HAyjYOZiC92AjhkH6xTliJuEeA0g+EgiL/ItC+jYJs3LM53e1F/
         kHb7LKXNiH/3jiLGvum83LYqVHTTtK/gOlogY=
Received: by 10.91.51.6 with SMTP id d6mr4931113agk.85.1277291156526; Wed, 23 
	Jun 2010 04:05:56 -0700 (PDT)
Received: by 10.90.25.8 with HTTP; Wed, 23 Jun 2010 04:05:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149507>

Hi

With increased adoption of GIT; there could be situations of splitting
/ merging Git Repositories.

If there is a support for splitting git repository and construction 2
pieces of repository as 2 independent repository with history

Mahesh
