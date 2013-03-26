From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Tue, 26 Mar 2013 10:27:32 +0700
Message-ID: <CACsJy8BDTMmrWr9mLxo26UZ3_4Tc2uy0Dy318j+4pyZ77q4=4Q@mail.gmail.com>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 04:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKKYq-0003J2-Qf
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 04:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847Ab3CZD2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 23:28:04 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:61335 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255Ab3CZD2D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 23:28:03 -0400
Received: by mail-ob0-f177.google.com with SMTP id eh20so6748696obb.36
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 20:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9T7oHNXfeBcJi9cKo1whANcGskQcMcYfts6WWRVixD0=;
        b=f8rSX3cQ5qIhsg21OamKRBwA8O9FBUzWrv+e2g4+YZedbstVxkobrkkIbQkhLkTqZP
         7N1YQ9EOAYZn8LP6IyF5iwc+oiK6+eLOFB1F2EF6VWNrBASGep5QlyzTz+qDJOdbkOxm
         iT6Nlsp4qKvbpUxRigWfdbrPme73XGQvQmMtegbmzaQfWwul4HpMRXPk6vDieW9zu4bV
         /YQOv1/88rKzf9QiyyB+VHO5A05pPSn+w9UvgVUOjuolY5xuYHF9ROa4RixnOxBAVGQp
         f4HU34iqAdF2bJOjomGSnV5tt8/DY87bQduC9mZxd5MwdzOFwdztynxa0VAh/cOJUsVH
         1q9w==
X-Received: by 10.60.31.79 with SMTP id y15mr13035331oeh.123.1364268482164;
 Mon, 25 Mar 2013 20:28:02 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Mon, 25 Mar 2013 20:27:32 -0700 (PDT)
In-Reply-To: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219128>

On Mon, Mar 25, 2013 at 12:38 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Git 2.0 is coming soon, so I'm excited about breaking a lot of
> backward compatibility ;)

It's a long way to 1.39 before we jump to 2.0 ;)
-- 
Duy
