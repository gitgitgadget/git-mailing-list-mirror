From: Stefan Beller <sbeller@google.com>
Subject: Fwd: An interesting opinion on DVCS/git
Date: Sun, 1 Mar 2015 19:29:30 -0800
Message-ID: <CAGZ79kZ8CrjwVh3+OHSV1tv+fRXaDZ_diOO5E7QnSLZ=HTFSfg@mail.gmail.com>
References: <54F2CD12.8050609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 04:29:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSH32-00054A-Fk
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 04:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbbCBD3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 22:29:32 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:43388 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbbCBD3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 22:29:31 -0500
Received: by igbhn18 with SMTP id hn18so13997525igb.2
        for <git@vger.kernel.org>; Sun, 01 Mar 2015 19:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=Zv2OvRKkmOSYbvoC9a7o8dOsZGZy7tGVz6QKbcOuvPA=;
        b=UKPWqNSLwKrPMdSG0myrzkVUiMxZEFueXTEq2zSLJ5+FjqD+E733Nb1Al2l2zq0HSQ
         3RqX8yicdBJTA6wcJes66ShmiMmBouE9RX1NUqLGN33L6xyJZOA/DCWZne3+n19YQzDR
         yzJ3AhXapLtR74pPQ3qAcpRH87Dyr0nQNEX91+WFv+so36WD5D5SNym1GjvJCgRAJaCf
         03pQljx9LG4SFHh9e3B5dQGJv0cL6+jRT4Z+xmziQAcaldpDYgyfhOaLp85/fS49kWn+
         nEsB5yJ1Zup4B++uhAjoh+5sp+uGmU5Bb3IrAveXRk/K7d/LTICOWapQqdXOCOM5gA/Z
         kMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=Zv2OvRKkmOSYbvoC9a7o8dOsZGZy7tGVz6QKbcOuvPA=;
        b=XlhGLMOl4WmyM4pIbkv7XOL3AWL49h0wGht9dizYp7p9j04gMhQoX/x54csMB8sOHI
         2KMTmXlrmOPF+W+zrdeehMITvtf4PwtkjWgOmNnv1DYVTIDj9yUiBVw7zweX9Dp2QnAn
         C4mIJLYuZC8X3A7s4PCAowA4f0cM7pNWQ0FtMzv/yDRXzoHhARR+COESXaEP6zCIX82a
         YScOwWAODwEdXFUmWVOflsbomz/XSQL+Xh2KDgm4iW6skbUF4cHJqCOnGboiLLPxfoWE
         bSyRG7VgnDAqo6h+5GEEKS8+OE56+0Fr+p6k4tVhv2bw7l0jed9ev466mEuEtQ4vcHxU
         Tqzw==
X-Gm-Message-State: ALoCoQlf3jadpOcIeVkCq3EqJdxI/jwh3vAu1TFoIre8lM8VnX2KVxT6TTjBR9G0QNN359hZcuzt
X-Received: by 10.43.10.6 with SMTP id oy6mr29302610icb.76.1425266970800; Sun,
 01 Mar 2015 19:29:30 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Sun, 1 Mar 2015 19:29:30 -0800 (PST)
In-Reply-To: <54F2CD12.8050609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264576>

bitquabit.com/post/unorthodocs-abandon-your-dvcs-and-return-to-sanity
