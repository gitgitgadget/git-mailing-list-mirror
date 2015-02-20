From: sojourner <sojournerh@gmail.com>
Subject: git mac 10.7.x
Date: Fri, 20 Feb 2015 05:38:03 -0500
Message-ID: <24CFF4AD-D1EE-40EA-A5F1-9109F29800BE@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 11:38:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOkyN-0006aV-03
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbbBTKiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:38:10 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:52269 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbbBTKiJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 05:38:09 -0500
Received: by mail-qg0-f48.google.com with SMTP id a108so13159641qge.7
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 02:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version;
        bh=JkTS0MGMDQ7UsZsZkFCAjNOwa1vLkKMBQXmDi2PEYO4=;
        b=vkFoaS5IGG+bcglc5ky7vwJeNutff2gKUuWsMAN0Av5Wlws7nYZ3NR8WMPbV++KCUH
         //GrF01VMokCMS7pwnRpoBqi+LF4dZsC3uPGhcxKnYNjBqrqOD6XktxSuM01htU1XQOv
         wb8/GaGAexuLlhmAGVTDxf/qytNNj2nTqEQyvndTsa/B4Os7PcxXGHesPwrJ8+ycOqFQ
         E1HyxfOuK+3u4Lrq1s7ikUZhzapNR0LmQa2xwANi66ny2J7LvynGxjpll/b50GKhmkSF
         DtsVoFMmqXEjnRQXXkDBXrHCkDy/04z3gpSxPv3dXnh+wCjhnaggzfG4N+JIjcPB7omp
         8H0w==
X-Received: by 10.141.28.65 with SMTP id f62mr22464846qhe.90.1424428688363;
        Fri, 20 Feb 2015 02:38:08 -0800 (PST)
Received: from [192.168.6.119] (ip-64-134-69-69.public.wayport.net. [64.134.69.69])
        by mx.google.com with ESMTPSA id l64sm21581415qgf.16.2015.02.20.02.38.06
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 20 Feb 2015 02:38:07 -0800 (PST)
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264158>

Installed Git via installer. Updated path in .bash_profile. Get error Illegal instruction: 4 when trying to run Git.

Built Git from source. Searches for the compiled source unsuccessful. Which is nice: there's nothing to uninstall. 

Searching online has a lot of suggestions and ideas. Anybody have anything that actually works?