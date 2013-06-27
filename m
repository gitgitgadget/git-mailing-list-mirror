From: Woody Wu <narkewoody@gmail.com>
Subject: Off-line deverloper workflow?
Date: Thu, 27 Jun 2013 20:46:56 +0800
Message-ID: <20130627124656.GA2620@zuhnb712>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 27 14:46:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsBbG-0001uJ-6K
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 14:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab3F0Mqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 08:46:54 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:42643 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab3F0Mqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 08:46:53 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so375566pdj.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=KVBffRnhVs9g296/uJx4fL6HtjtMT+c4phe+v2Vflu4=;
        b=PSQBPm0v7VSsp4m+BrF3PvCFdC2hzr6DW/p/O/gMv8amGM/VaQMIMcSjRyuxVQYjf8
         hBo0qnEjjQ+uQV1Uv7viGV8+2Wt7k5mNsgtkdloS0B1Z/wzg8DHiqWIjfbdcxpTyeQ+M
         FXg1yx5CxLjBCu3/mH3Qdjxz+FfziMfEri9imOJwoHe0ChwSCL+/H9moruySqN6nI6h5
         somGQwnjD/CMSlAmRmI1AducXF+Zh+8EaEYvk19shIHAnl/gGUIkFt1bL/iYNNMSGIxu
         nMoCULy0MW015j6N1ECBTLzfIasmTx8Dtc6ObWgNgAqV9SzAJTQCN3La6J1FOYixvoZX
         aVtQ==
X-Received: by 10.66.164.232 with SMTP id yt8mr5932710pab.21.1372337213238;
        Thu, 27 Jun 2013 05:46:53 -0700 (PDT)
Received: from localhost ([119.120.31.222])
        by mx.google.com with ESMTPSA id v20sm3676124paj.4.2013.06.27.05.46.50
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 05:46:52 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229096>

Hi,

I have a colleague who has to left our office for three month, but still
need to work on the project which is hosted on our in-office git
repository. Problem is that our company has firewall, it's not possible
or not allowed to access the company LAN outside the building.  So I
want to ask you expert, can you suggest a best practice of git workflow
that suitable to my situation?

Thanks in advance.

-woody
