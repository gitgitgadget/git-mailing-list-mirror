From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 22:50:39 -0500
Message-ID: <CAMP44s1e-kjVnAHQx3GOAG6ge_GZBmOBaCnr8YeyU6t5CveuzA@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s20njF9u9tRKM6J92-oqeLHoLqd30R-A7opTG7bdrTJzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 05:50:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfMYB-00086h-A0
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 05:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588Ab3EWDum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 23:50:42 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:44295 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3EWDum (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 23:50:42 -0400
Received: by mail-lb0-f177.google.com with SMTP id o10so2827040lbi.8
        for <git@vger.kernel.org>; Wed, 22 May 2013 20:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PBiuybo6wqSmL43svALobEa4UuZdvD8gKv96T90vlyI=;
        b=BPUX0VCiYwGGfA1hOdlJGt7M0DAnIQI8Z5bMN6FnTJQe75XpjdKNqwXqNkGhzmtp3+
         2PDu+qXGBl9PYByLJnagS/ZCp/9KqntO9JtaqYqSSDGb31RYhNQTyHSK1DTawPm8GPv6
         Hc1YX0W7vGvOjse1aFjzAjzH+TxOe/YUrQDdAkTfOaPZXnmUgCn6xVJ4kYN30n2ZwqlF
         exx5z+D1futcdEKqDUPIAhgGFvTIpMoLcN9tCj2orRLLnQNDZRdpFWxBp8OvKb/gpkW4
         ev5i3GLsdFZy6q6XceQhBCbhMIH5qY8WpUrRslzPdHZZtF5D9YuMNiP21lm3OcOJHWnV
         6/Fg==
X-Received: by 10.112.63.169 with SMTP id h9mr5425964lbs.135.1369281039152;
 Wed, 22 May 2013 20:50:39 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Wed, 22 May 2013 20:50:39 -0700 (PDT)
In-Reply-To: <CAMP44s20njF9u9tRKM6J92-oqeLHoLqd30R-A7opTG7bdrTJzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225210>

On Wed, May 22, 2013 at 10:23 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This doesn't make any sense:

Ah, never mind, it's COPYING the one being modified, not EXTRACTING.

-- 
Felipe Contreras
