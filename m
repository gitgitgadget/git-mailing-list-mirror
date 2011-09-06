From: =?ISO-8859-1?Q?Rodrigo_Cort=E9s?= <rcortes.ing@gmail.com>
Subject: Tracking database changes.
Date: Tue, 6 Sep 2011 18:55:56 -0300
Message-ID: <CAFSYZ5RjJYHByTMPu6LiM6awGitt3WqnVrLU34mA9t7O1MVHDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 23:58:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R13en-0001op-II
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 23:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab1IFVz6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Sep 2011 17:55:58 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40008 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab1IFVz5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2011 17:55:57 -0400
Received: by yxj19 with SMTP id 19so3358029yxj.19
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=w2w+t/n9hgsPNHxG/IgPeOimT7C/mRlO0CTK38C81AI=;
        b=KTro9CVPmAvh5On4TFFcaeThd8W87+kV4+3CUBNkfjn4y3036dIdDpk9h8UtwqpJAI
         Ngt/hpq1I/CPojUahN1VstnVDpzp3qG1wmkJppw/uMRZUhtOkercoi3KlfHIrsCg78J2
         vRCRU8RI/k94KT6+AWFHs67/YtwFY6VdJSIKo=
Received: by 10.42.142.132 with SMTP id s4mr4668481icu.266.1315346156233; Tue,
 06 Sep 2011 14:55:56 -0700 (PDT)
Received: by 10.231.145.7 with HTTP; Tue, 6 Sep 2011 14:55:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180841>

Is there a way to use git to track database changes?

--=20
Rodrigo Cort=E9s Carvajal
Ingenier=EDa El=E9ctrica
Universidad Tecnol=F3gica de Chile
