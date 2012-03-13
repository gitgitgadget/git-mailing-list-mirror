From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v7 00/9] Column display
Date: Tue, 13 Mar 2012 19:08:20 +0700
Message-ID: <CACsJy8BZ9yFQ7bWsLf5O56zwrSzcj487syVRiQ2s5XoPuNkahQ@mail.gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com> <cover.1331638663.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:08:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QXB-0006ml-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759495Ab2CMMIy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 08:08:54 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49068 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759398Ab2CMMIv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 08:08:51 -0400
Received: by wibhj6 with SMTP id hj6so5307549wib.1
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YHa56amilgiOeLc5YovMI8TMll0YeS7qlft1ZhZrWQY=;
        b=taBpnadU1CcUmuBWCXuDlvKHM0giM4zxXXc7Hj3ufZv6aItY11gpb53c6qhbMYyn0w
         6XpZc+nxaXxVRagnW7qLRRW7XGa/4QORwTVxJMFv+2H/+ApXiKzOC9gj0RbffpF8j5VV
         vQfLRJXoIVEq/K9LmVMJnWGXNTl4mWEDwm22FRPrDKS5ExEH+xmGDnbrigt1uYVvo/cu
         6OnKRbyFbr8CDY+SuaqAzYZuh3l3EMRVNYyt+pF2NtB9IYgDaJ2JgDBiV2a6gindH6cw
         UU+zB88Ja98j4EGfcqkXBwdV+RVniubgo/B5UfA5C29GL1Mn0iuTRvXyYZ9uIc+0hOWG
         HFLQ==
Received: by 10.180.96.228 with SMTP id dv4mr4797161wib.14.1331640530564; Tue,
 13 Mar 2012 05:08:50 -0700 (PDT)
Received: by 10.223.13.5 with HTTP; Tue, 13 Mar 2012 05:08:20 -0700 (PDT)
In-Reply-To: <cover.1331638663.git.pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193007>

2012/3/13 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> This series fixes problems found in v6:

This series is actually v8, changes compared to the replied-to v7.
Sorry I messed it up.
--=20
Duy
