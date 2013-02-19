From: Juan Pablo <juanpablo8517@gmail.com>
Subject: Can git restrict source files ?
Date: Tue, 19 Feb 2013 11:06:07 -0500
Message-ID: <DE551AEA-5C7D-4A2D-8AB4-33195EF351F8@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:06:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7piI-0008PV-93
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 17:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691Ab3BSQGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 11:06:14 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:59993 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491Ab3BSQGN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2013 11:06:13 -0500
Received: by mail-qc0-f177.google.com with SMTP id u28so2594247qcs.22
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:content-type:content-transfer-encoding:subject:from
         :message-id:date:to:mime-version:x-mailer;
        bh=8D1x+261bxGHZVbhf2yTIHi0ZLugT0ihZp5a6+N19TU=;
        b=KFMgP2aq7GaJevUiX7SjsEL3FNvdeb51KCPKOctwlVlIHGNkWY9dbL3OPN5yICNojm
         q09u0ycSiXCtwOvpJiH2d19YXMaXr6WG7nidZ1+DZ16G59ySTTFaI0p8dz5G8LxK8dPc
         TY+tDbLEN3pDkqEy2oBW9o6mmGjUEnTZuhhL9XiQFVgIbOSL5OaaZk3+TYdVWhyXRolE
         VLIS00oGE42bkw/6Zjuit/B+91xI+AFQW9vEfaVv+FMgCx0fWfW53COkmYa4SdIbmIRa
         YJSOZliVGzUTKbg/U8t8h6FiXoky5LGiCnlnjCgwyyqkVjDmCDnfzJT0EDh3ZrDmOQkY
         SGbg==
X-Received: by 10.229.76.37 with SMTP id a37mr1577455qck.130.1361289970644;
        Tue, 19 Feb 2013 08:06:10 -0800 (PST)
Received: from [181.69.167.210] ([181.69.167.210])
        by mx.google.com with ESMTPS id hr3sm27984474qab.4.2013.02.19.08.06.08
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 19 Feb 2013 08:06:09 -0800 (PST)
X-Mailer: iPhone Mail (10B143)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216627>

Hi, 

I have a question, can i control the access to specific files or folders ?? I need that some developers can't see some source files, thank you very much for your time

Enviado desde mi iPhone