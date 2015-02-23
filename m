From: Sebastien COUDERT <coupdair@gmail.com>
Subject: git bash with rsync
Date: Mon, 23 Feb 2015 22:33:41 +0100
Message-ID: <CAPNz-yTeAkPttU5+3o4NEWDZmUs9pwNoZtiUtHcDD3N9XS9E6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 22:33:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ0dO-0000SE-Dn
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 22:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbbBWVdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 16:33:42 -0500
Received: from mail-qc0-f182.google.com ([209.85.216.182]:47060 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbBWVdl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 16:33:41 -0500
Received: by qcxr5 with SMTP id r5so13493065qcx.13
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 13:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=NawkSbpCGKtOBIdT2hA/iVF9+UFkt8NssC/t7OaoPQg=;
        b=lPgs6I14PnBP/051iNn4Da7uHv3Xgt39S7Uh7Fh4DV2a5JYNecCqkJp7TgvaTo1cey
         2AqIEn6o+UXny0Ky3i5wKCgCUkt3MQdcuSCOGQwHnxuLdiiH8cShEqOZy4uH0JtmpTq2
         HxrzGoj5FrWg7cfaFamLwnuIjCCUmEpwlxefvqHLvkmykTuD0eDD/uZG3J6BT8OGCcM0
         otGGHu2M+vtMIrlWvaIiCo6NZas5wlYLUVCxAU67qJQaa8G4kzUDRB8rTlZChqTSCne5
         Wu4EIZrjoLc3IoeMygalPOuTRpU91IZXYfRMRNdx5E4xJ9COsc//M1nkWyfJ0XKKzUpT
         fuIw==
X-Received: by 10.140.107.75 with SMTP id g69mr27931376qgf.103.1424727221051;
 Mon, 23 Feb 2015 13:33:41 -0800 (PST)
Received: by 10.140.143.208 with HTTP; Mon, 23 Feb 2015 13:33:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264301>

Hi,

this is a comment to enhance
the git distribution under Window$.

It would be a nice feature to add rsync
to git bash distribution for Window$.
In order to be able to show how powerful is GNU tools,
to those how still works under M$ OS,
or those that are forced to.

As far as I know, adding rsync is very tiny
(both work and space),
as ssh is all ready in the git bash package.

Many thanks (especially for the git project).

Sebastien.
