From: Tom Michaud <tom.michaud@gmail.com>
Subject: Workflow for git dev
Date: Thu, 2 Feb 2012 07:59:53 -0700
Message-ID: <CALDO3MKFdZ85w5uJEcZ6dkC7SNXxKi7BAb7r78ciFzmNdjo7eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 02 16:00:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsy97-0000w2-5y
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 16:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432Ab2BBPAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 10:00:15 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63503 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab2BBPAO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 10:00:14 -0500
Received: by eekc14 with SMTP id c14so799322eek.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=a2ZcJ3/Yw6wZvcOeKeTPHu0t58pr/b6JRiVpJFdFlCI=;
        b=H6Hlto+aVPPa9/wFsIENBOMQz3CILLD7e3i3Ti4wHPgA0XGEp+xFl2Gq/drSUBk0H2
         c/8neXTLoKkPXPs3J3QvKnZZ66fPuXfecqNaDc0dyb4jzBPgRLPp71HTlaSHuEz/166g
         VDeCZ/+0bqRc/oaBdUm54tCqyjV5Z/8jj5lM4=
Received: by 10.14.131.13 with SMTP id l13mr1013990eei.45.1328194813195; Thu,
 02 Feb 2012 07:00:13 -0800 (PST)
Received: by 10.213.22.80 with HTTP; Thu, 2 Feb 2012 06:59:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189650>

Hi all,

Would someone kindly point me to a document that describes the
workflow Junio et al use to develop git?

Much appreciated,
Tom
